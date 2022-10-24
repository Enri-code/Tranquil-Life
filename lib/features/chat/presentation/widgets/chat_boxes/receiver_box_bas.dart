import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/chat_box.dart';

class ReceiverChatBoxBase extends StatelessWidget {
  const ReceiverChatBoxBase({
    Key? key,
    required this.child,
    required this.time,
    this.padding = 5,
  }) : super(key: key);

  final double padding;
  final Widget child;
  final String time;

  @override
  Widget build(BuildContext context) {
    return ChatBox(
      time: time,
      color: Colors.white,
      axisAlignment: CrossAxisAlignment.start,
      child: child,
    );
  }
}
