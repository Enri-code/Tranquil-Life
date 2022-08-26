import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_box.dart';

class RepliedChatBox extends StatelessWidget {
  const RepliedChatBox(this.message, {Key? key, required this.backgroundColor})
      : super(key: key);

  final Color backgroundColor;
  final ReplyMessage message;

  Widget _text(Message message) {
    switch (message.type) {
      case MessageType.image:
      case MessageType.video:
      case MessageType.voiceNote:
      default:
        return Text(
          message.data,
          style: const TextStyle(color: Colors.white70),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ChatBoxBase(
        padding: 8,
        heightScale: 0.9,
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.fromYou ? 'You' : 'Dr Charlie', //TODO
              style: TextStyle(
                color: Color.lerp(
                  Colors.white,
                  Theme.of(context).primaryColor,
                  0.3,
                )!,
              ),
            ),
            const SizedBox(height: 3),
            _text(message.repliedMessage),
          ],
        ),
      ),
    );
  }
}
