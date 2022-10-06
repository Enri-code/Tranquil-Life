import 'package:tranquil_life/features/chat/domain/entities/message.dart';

class ReplyMessage extends Message {
  final Message repliedMessage;

  const ReplyMessage({
    required super.id,
    required super.data,
    required this.repliedMessage,
    super.type,
    super.fromYou,
    super.isSent,
    super.timeSent,
  });

  @override
  List<Object?> get props => [...super.props, repliedMessage];
}
