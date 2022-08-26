import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_boxes/sender_box_base.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/replied_chat_box.dart';

class SenderChatText extends StatelessWidget {
  const SenderChatText(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return SenderChatBoxBase(
      time: message.timeSent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message is ReplyMessage)
            RepliedChatBox(
              message as ReplyMessage,
              backgroundColor: Color.lerp(
                Colors.black,
                Theme.of(context).primaryColor,
                0.82,
              )!,
            ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              message.data,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
