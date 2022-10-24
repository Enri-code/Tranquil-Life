import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/chat_box.dart';

class SenderChatBoxBase extends StatelessWidget {
  const SenderChatBoxBase({
    Key? key,
    required this.child,
    this.padding = 5,
    this.time,
  }) : super(key: key);

  final double padding;
  final Widget child;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return ChatBox(
      time: time ?? 'Sending',
      color: Theme.of(context).primaryColor,
      axisAlignment: CrossAxisAlignment.end,
      child: child,
    );
  }
}
