import 'package:flutter/material.dart';

class InputListener extends StatefulWidget {
  const InputListener({
    Key? key,
    required this.child,
    required this.onInput,
  }) : super(key: key);

  final Widget child;
  final Function() onInput;

  @override
  State<InputListener> createState() => _InputListenerState();
}

class _InputListenerState extends State<InputListener> {
  final _keyboardNode = FocusNode();

  @override
  void dispose() {
    _keyboardNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) => widget.onInput,
      onPointerCancel: (_) => widget.onInput,
      behavior: HitTestBehavior.translucent,
      child: RawKeyboardListener(
        focusNode: _keyboardNode,
        onKey: (_) => widget.onInput,
        child: widget.child,
      ),
    );
  }
}
