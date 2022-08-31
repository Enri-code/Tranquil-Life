import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/replied_chat_box.dart';

class ReceiverReplyBox extends StatelessWidget {
  const ReceiverReplyBox(this.message, {Key? key}) : super(key: key);
  final ReplyMessage message;

  @override
  Widget build(BuildContext context) {
    return RepliedChatBox(
      message,
      backgroundColor: const Color(0xffE1DFDF),
    );
  }
}
