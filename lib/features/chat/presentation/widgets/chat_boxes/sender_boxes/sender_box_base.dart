import 'package:flutter/material.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_box.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: ChatBoxBase(
              color: Theme.of(context).primaryColor,
              padding: padding,
              child: child,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time ?? 'Sending...',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
