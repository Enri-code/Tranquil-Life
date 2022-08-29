import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/core/constants/constants.dart';

class ChatBoxBase extends StatelessWidget {
  const ChatBoxBase({
    Key? key,
    required this.child,
    required this.color,
    this.heightScale = 1,
    this.padding = 12,
  }) : super(key: key);

  final double heightScale;
  final double padding;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: chatBoxMaxWidth),
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10 * heightScale),
        ),
        child: MyDefaultTextStyle(
          style: TextStyle(
            height: 1.3 * heightScale,
            fontSize: 16 * heightScale,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10 * heightScale),
            child: child,
          ),
        ),
      ),
    );
  }
}
