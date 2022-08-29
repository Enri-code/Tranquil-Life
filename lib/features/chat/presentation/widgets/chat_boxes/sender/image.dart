import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/reply_box.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/image_layout.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_box_base.dart';

class SenderChatImage extends StatelessWidget {
  const SenderChatImage(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return SenderChatBoxBase(
      padding: 3,
      time: message.timeSent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (message is ReplyMessage)
            Padding(
              padding: const EdgeInsets.all(2),
              child: SenderReplyBox(message as ReplyMessage),
            ),
          ChatImageLayout(message: message),
        ],
      ),
    );
  }
}
