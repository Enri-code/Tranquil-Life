import 'package:tranquil_life/features/chat/domain/entities/message.dart';

class ReplyMessage extends Message {
  final Message repliedMessage;

  const ReplyMessage({
    required super.id,
    required super.text,
    required this.repliedMessage,
    super.fromYou = true,
    super.isSent = true,
    super.timeSent,
  });
}
