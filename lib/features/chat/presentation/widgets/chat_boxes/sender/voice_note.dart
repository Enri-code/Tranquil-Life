import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender/reply_box.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_box_base.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/voice_note_layout.dart';

class SenderChatVoiceNote extends StatelessWidget {
  const SenderChatVoiceNote(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return SenderChatBoxBase(
      time: message.timeSent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message is ReplyMessage) SenderReplyBox(message as ReplyMessage),
          VoiceNoteLayout(message: message),
        ],
      ),
    );
  }
}
