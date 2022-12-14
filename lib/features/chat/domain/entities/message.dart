import 'package:equatable/equatable.dart';

enum MessageType { text, image, video, audio }

class Message extends Equatable {
  final int? id;
  final bool fromYou;
  final bool isSent;
  final String data;
  final MessageType type;
  final String? timeSent;

  const Message({
    required this.data,
    this.id,
    this.type = MessageType.text,
    this.fromYou = true,
    this.isSent = true,
    this.timeSent = '8 PM',
  });

  @override
  List<Object?> get props => [id, type, isSent, timeSent, fromYou];
}
