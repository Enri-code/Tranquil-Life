import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/app/presentation/widgets/swipeable.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/core/utils/services/time_formatter.dart';
import 'package:tranquil_life/features/chat/presentation/screens/call_page.dart';
import 'package:tranquil_life/features/chat/data/audio_recorder.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/attachment_sheet.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/image.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/text.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/video.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/voice_note.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/image.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/text.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/video.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/voice_note.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_more_options.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/dialogs/disable_account_dialog.dart';

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
              child: Column(
                children: const [
                  _TitleBar(),
                  Expanded(child: _Messages()),
                  SafeArea(top: false, child: _InputBar()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBox extends StatelessWidget {
  const _ChatBox(
    this.message, {
    Key? key,
    required this.animate,
    required this.highlightAnim,
  }) : super(key: key);

  final Message message;
  final bool animate;
  final Animation<double> highlightAnim;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animate ? highlightAnim : const AlwaysStoppedAnimation(0),
      builder: (context, _) => Container(
        color: Theme.of(context).primaryColor.withOpacity(
              animate ? highlightAnim.value * 0.4 : 0.0,
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: () {
            if (message.fromYou) {
              switch (message.type) {
                case MessageType.image:
                  return SenderChatImage(message);
                case MessageType.video:
                  return SenderChatVideo(message);
                case MessageType.audio:
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
                case MessageType.audio:
                  return ReceiverChatVoiceNote(message);
                default:
                  return ReceiverChatText(message);
              }
            }
          }(),
        ),
      ),
    );
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
          if (state.messages.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'No messages here yet.\nTalk to your consultant!',
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.5,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text('👋', style: TextStyle(fontSize: 64)),
                  ],
                ),
              ),
            );
          }
          return BlocConsumer<ChatBloc, ChatState>(
            listenWhen: (prev, curr) {
              return prev.highlightIndex != curr.highlightIndex;
            },
            listener: (_, __) => animController.forward(from: 0),
            builder: (context, state) {
              return ScrollablePositionedList.builder(
                reverse: true,
                itemCount: state.messages.length,
                physics: const BouncingScrollPhysics(),
                itemScrollController: context.read<ChatBloc>().scrollController,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                itemBuilder: (_, index) => _ChatBox(
                  // key: ValueKey(messages[index].id ?? 'sending-$index'),
                  state.messages[index],
                  highlightAnim: highlightAnim,
                  animate: index == state.highlightIndex,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
