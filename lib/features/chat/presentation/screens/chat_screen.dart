import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/app/presentation/widgets/back_button_white.dart';
import 'package:tranquil_life/app/presentation/widgets/swipeable.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/core/utils/services/media_service.dart';
import 'package:tranquil_life/core/utils/services/time_formatter.dart';
import 'package:tranquil_life/features/calls/presentation/screens/call_page.dart';
import 'package:tranquil_life/features/chat/data/audio_recorder.dart';
import 'package:tranquil_life/features/chat/data/samples.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/image.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/text.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/video.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/voice_note.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/image.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/text.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/video.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/voice_note.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_more_options.dart';

part '../widgets/chat_app_bar.dart';
part '../widgets/input_bar.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness(false);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/chat_bg.png'),
            fit: BoxFit.cover,
            color: Colors.black26,
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: BlocProvider(
                create: (_) => ChatBloc(),
                child: Column(
                  children: const [
                    _TitleBar(),
                    Expanded(child: _Messages()),
                    SafeArea(top: false, child: _InputBar()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBox extends StatelessWidget {
  const _ChatBox(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    if (message.fromYou) {
      switch (message.type) {
        case MessageType.image:
          return SenderChatImage(message);
        case MessageType.video:
          return SenderChatVideo(message);
        case MessageType.voiceNote:
          return SenderChatVoiceNote(message);
        default:
          return SenderChatText(message);
      }
    } else {
      switch (message.type) {
        case MessageType.image:
          return ReceiverChatImage(message);
        case MessageType.video:
          return ReceiverChatVideo(message);
        case MessageType.voiceNote:
          return ReceiverChatVoiceNote(message);
        default:
          return ReceiverChatText(message);
      }
    }
  }
}

class _Messages extends StatefulWidget {
  const _Messages({Key? key}) : super(key: key);

  @override
  State<_Messages> createState() => _MessagesState();
}

class _MessagesState extends State<_Messages>
    with SingleTickerProviderStateMixin {
  late final AnimationController animController;
  late final Animation<double> highlightAnim;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..animateTo(1, duration: Duration.zero);
    highlightAnim = animController.drive(TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 0.8),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 0.2),
    ]));
    super.initState();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusWidget(
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (messages.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'No messages here yet.\nTalk to your consultant! 👋',
                  style: TextStyle(color: Colors.white, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return BlocListener<ChatBloc, ChatState>(
            listenWhen: (prev, curr) => prev.chatIndex != curr.chatIndex,
            listener: (_, __) => animController.forward(from: 0),
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) => ScrollablePositionedList.builder(
                reverse: true,
                itemCount: messages.length,
                physics: const BouncingScrollPhysics(),
                itemScrollController: context.read<ChatBloc>().scrollController,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                itemBuilder: (_, index) {
                  final bool animate = index == state.chatIndex;
                  return AnimatedBuilder(
                    key: ValueKey(index),
                    animation: animate
                        ? highlightAnim
                        : const AlwaysStoppedAnimation(0),
                    builder: (context, _) => Container(
                      color: Theme.of(context).primaryColor.withOpacity(
                            animate ? highlightAnim.value * 0.4 : 0.0,
                          ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _ChatBox(messages[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
