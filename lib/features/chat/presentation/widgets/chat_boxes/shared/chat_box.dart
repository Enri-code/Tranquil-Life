import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/swipeable.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/chat_box_base.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    Key? key,
    required this.child,
    required this.time,
    required this.color,
    required this.axisAlignment,
    this.padding = 5,
  }) : super(key: key);

  final String time;
  final Color color;
  final Widget child;
  final double padding;
  final CrossAxisAlignment axisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: axisAlignment,
        children: [
          Flexible(
            child: SwipeableWidget(
              resetOnRelease: true,
              alignment: Alignment.centerRight,
              swipedWidget: const Icon(Icons.reply, color: Colors.white),
              child: GestureDetector(
                onLongPress: () {},
                child: ChatBoxBase(
                  color: color,
                  padding: padding,
                  child: child,
                ),
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
