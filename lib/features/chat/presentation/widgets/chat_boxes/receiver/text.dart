import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver/reply_box.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/receiver_box_bas.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/text_layout.dart';

class ReceiverChatText extends StatelessWidget {
  const ReceiverChatText(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return ReceiverChatBoxBase(
      time: message.timeSent!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message is ReplyMessage)
            ReceiverReplyBox(message as ReplyMessage),
          TextLayout(message: message),
        ],
      ),
    );
  }
}
