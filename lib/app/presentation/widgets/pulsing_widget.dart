import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PulsingWidget extends StatefulWidget {
  const PulsingWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<PulsingWidget> createState() => _PulsingWidgetState();
}

class _PulsingWidgetState extends State<PulsingWidget> {
  bool atEnd = true;
  static const _minOpacity = 0.2;
  static const _maxOpacity = 0.5;
  double opacity = _minOpacity;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => setState(() => opacity = _maxOpacity));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 600),
      onEnd: () {
        setState(() => opacity = atEnd ? _minOpacity : _maxOpacity);
        atEnd = !atEnd;
      },
      child: widget.child,
    );
  }
}
