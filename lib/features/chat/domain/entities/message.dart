enum MessageType { text, image, video, voicenote }

class Message {
  final int id;
  final bool fromYou;
  final bool isSent;
  final String text;
  final MessageType type;
  final String? timeSent;

  const Message({
    required this.id,
    required this.text,
    this.type = MessageType.text,
    this.fromYou = true,
    this.isSent = true,
    this.timeSent,
  });
}
