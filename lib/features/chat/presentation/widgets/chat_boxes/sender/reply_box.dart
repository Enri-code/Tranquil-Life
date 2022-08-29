import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/replied_chat_box.dart';

class SenderReplyBox extends StatelessWidget {
  const SenderReplyBox(this.message, {Key? key}) : super(key: key);

  final ReplyMessage message;

  @override
  Widget build(BuildContext context) {
    return RepliedChatBox(
      message,
      backgroundColor: Color.lerp(
        Colors.black,
        Theme.of(context).primaryColor,
        0.82,
      )!,
    );
  }
}
