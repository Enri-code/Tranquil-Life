import 'package:flutter/material.dart';

class MyDefaultTextStyle extends StatelessWidget {
  const MyDefaultTextStyle({
    Key? key,
    required this.child,
    required this.style,
    this.inherit = false,
    this.textAlign,
  }) : super(key: key);

  final bool inherit;
  final Widget child;
  final TextAlign? textAlign;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyText2!;
    return DefaultTextStyle(
      style: inherit
          ? style.copyWith(
              fontFamily: textTheme.fontFamily,
              height: textTheme.height,
            )
          : textTheme.merge(style),
      textAlign: textAlign,
      child: child,
    );
  }
}
