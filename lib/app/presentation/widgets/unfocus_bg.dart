import 'package:flutter/material.dart';

class UnfocusWidget extends StatelessWidget {
  const UnfocusWidget({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}
