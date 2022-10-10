import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/swipeable.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SwipeableWidget(
              resetOnRelease: true,
              alignment: Alignment.centerRight,
              swipedWidget: const Icon(Icons.reply, color: Colors.white),
              child: ChatBoxBase(
                color: Colors.white,
                padding: padding,
                child: child,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(time, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
