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
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_boxes/sender_video.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_boxes/sender_voice_note.dart';

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
            color: Colors.black26,
            colorBlendMode: BlendMode.darken,
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
    data: 'Hi, I have been some issues for a while and I need help.',
  );
  static final _messages = [
    _textMessage,
    ReplyMessage(
      id: 0,
      data: 'https://www.pexels.com/video/3195394/download/',
      repliedMessage: _textMessage,
    ),
    ReplyMessage(
      id: 0,
      data: 'https://www.pexels.com/video/3195394/download/',
      repliedMessage: _textMessage,
      type: MessageType.video,
    ),
    Message(
      id: 0,
      data: 'https://www.pexels.com/video/3195394/download/',
      type: MessageType.video,
    ),
    const ReplyMessage(
      id: 0,
      data: 'https://sounds-mp3.com/mp3/0001961.mp3',
      repliedMessage: _textMessage,
      type: MessageType.voiceNote,
    ),
    const Message(
      id: 0,
      data: 'https://sounds-mp3.com/mp3/0001961.mp3',
      type: MessageType.voiceNote,
    ),
    const ReplyMessage(
      id: 0,
      type: MessageType.image,
      repliedMessage: _textMessage,
      data:
          'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
    ),
    const Message(
      id: 0,
      type: MessageType.image,
      data:
          'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
    ),
    const Message(
      id: 0,
      data: 'Hi, I have been some issues.',
    ),
  ];

  Widget _chatBoxBuilder(Message message) {
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
        case MessageType.video:
        case MessageType.voiceNote:
        default:
          return SenderChatText(message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _messages.length,
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        MediaQuery.of(context).viewPadding.bottom,
      ),
      itemBuilder: (_, index) => _chatBoxBuilder(_messages[index]),
    );
  }
}
