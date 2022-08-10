import 'package:flutter/material.dart';

class MyDefaultTextStyle extends StatelessWidget {
  const MyDefaultTextStyle({
    Key? key,
    required this.child,
    required this.style,
  }) : super(key: key);

  final Widget child;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText1!.merge(style),
      child: child,
    );
  }
}
