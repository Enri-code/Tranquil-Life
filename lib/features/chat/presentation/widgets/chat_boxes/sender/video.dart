import 'package:flutter/material.dart';

import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/reply_box.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_box_base.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/video_layout.dart';

class SenderChatVideo extends StatelessWidget {
  const SenderChatVideo(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return SenderChatBoxBase(
      time: message.timeSent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (message is ReplyMessage) SenderReplyBox(message as ReplyMessage),
          VideoLayout(message: message),
        ],
      ),
    );
  }
}
