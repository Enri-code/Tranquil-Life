import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_boxes/sender_image.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_boxes/sender_text.dart';

part '../widgets/chat_more_options.dart';
part '../widgets/chat_app_bar.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness(false);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/chat_bg.png',
            color: Colors.black12,
            colorBlendMode: BlendMode.overlay,
            fit: BoxFit.cover,
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: const [
                  _TitleBar(),
                  Expanded(child: _Messages()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Messages extends StatelessWidget {
  const _Messages({Key? key}) : super(key: key);

  static const _textMessage = Message(
    id: 0,
    text: 'Hi, I have been some issues for a while and I need help.',
  );
  static final _messages = [
    _textMessage,
    ReplyMessage(
      id: 0,
      text: 'Please tell me, what issue are you facing?.',
      repliedMessage: _textMessage,
    ),
    const Message(
      id: 0,
      text: 'Hi, I have been some issues.',
    ),
    ReplyMessage(
      id: 0,
      text:
          'Please tell me, what issue are you facing? Hi, I have been some issues.',
      repliedMessage: _textMessage,
    ),
    const Message(
      id: 0,
      type: MessageType.image,
      text:
          'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
    ),
    ReplyMessage(
      id: 0,
      text: 'Please tell me, what issue are you facing?.',
      repliedMessage: _textMessage,
    ),
    const Message(
      id: 0,
      text: 'Hi, I have been some issues.',
    ),
    ReplyMessage(
      id: 0,
      text:
          'Please tell me, what issue are you facing? Hi, I have been some issues.',
      repliedMessage: _textMessage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        MediaQuery.of(context).viewPadding.bottom,
      ),
      itemBuilder: (_, index) => _chatBoxBuilder(_messages[index]),
    );
  }

  Widget _chatBoxBuilder(Message message) {
    if (message.fromYou) {
      switch (message.type) {
        case MessageType.image:
          return SenderChatImage(message);
        case MessageType.video:
        case MessageType.voicenote:
        default:
          return SenderChatText(message);
      }
    } else {
      switch (message.type) {
        case MessageType.image:
          return SenderChatImage(message);
        case MessageType.video:
        case MessageType.voicenote:
        default:
          return SenderChatText(message);
      }
    }
  }
}
