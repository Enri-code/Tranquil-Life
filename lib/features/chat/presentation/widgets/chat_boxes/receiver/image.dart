import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/reply_box.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver_box_bas.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/image_layout.dart';

class ReceiverChatImage extends StatelessWidget {
  const ReceiverChatImage(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return ReceiverChatBoxBase(
      padding: 3,
      time: message.timeSent!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (message is ReplyMessage)
            Padding(
              padding: const EdgeInsets.all(2),
              child: ReceiverReplyBox(message as ReplyMessage),
            ),
          ChatImageLayout(message: message),
        ],
      ),
    );
  }
}
