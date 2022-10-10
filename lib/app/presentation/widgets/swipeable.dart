import 'package:flutter/material.dart';

class SwipeableWidget extends StatefulWidget {
  const SwipeableWidget({
    Key? key,
    required this.child,
    this.swipedWidget,
    this.maxOffset,
    this.enabled = true,
    this.resetOnRelease = false,
    this.onStateChanged,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final Alignment alignment;
  final bool resetOnRelease, enabled;
  final double? maxOffset;
  final Widget? swipedWidget;
  final Widget child;

  final Function(bool isOpen)? onStateChanged;

  @override
  State<SwipeableWidget> createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animator;
  final curveAnim = CurveTween(curve: Curves.easeInBack);

  bool isOpen = false;
  double offset = 0, initialOffset = 0, lastOffset = 0;
  late double maxOffset;

  @override
  void initState() {
    animator = AnimationController(vsync: this, duration: kTabScrollDuration)
      ..addListener(() {
        var toPosition = isOpen ? maxOffset : lastOffset;
        var val = curveAnim.animate(animator).value;
        setState(() => offset = toPosition * val);
      });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maxOffset = -(widget.maxOffset ?? MediaQuery.of(context).size.width * 0.15);
  }

  @override
  void didUpdateWidget(covariant SwipeableWidget oldWidget) {
    if (!widget.resetOnRelease) _animateTo(false);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animator.dispose();
    super.dispose();
  }

  Future _animateTo(bool end) async {
    isOpen = end;
    lastOffset = offset;
    widget.onStateChanged?.call(end);
    if (widget.resetOnRelease && end) {
      animator.reset();
      await animator.animateTo(1, curve: Curves.linear);
      await animator.animateTo(0, curve: Curves.linear);
      return;
    }
    if (end) {
      await animator.forward(from: 0);
    } else {
      await animator.reverse(from: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage = offset / maxOffset;
    return Stack(
      alignment: widget.alignment,
      children: [
        if (widget.swipedWidget != null)
          Transform.scale(
            scale: percentage * 0.3 + 0.7,
            child: Opacity(
              opacity: Curves.easeIn.transform(percentage.clamp(0, 1)),
              child: Listener(
                onPointerUp: (_) => _animateTo(false),
                behavior: HitTestBehavior.translucent,
                child: widget.swipedWidget!,
              ),
            ),
          ),
        if (widget.enabled)
          GestureDetector(
            onTap: () {
              if (isOpen && !widget.resetOnRelease) _animateTo(false);
            },
            onHorizontalDragStart: (details) =>
                initialOffset = details.localPosition.dx,
            onHorizontalDragUpdate: (details) {
              if (details.localPosition.dx < initialOffset) {
                if (offset > maxOffset) {
                  setState(() {
                    offset = details.localPosition.dx - initialOffset;
                  });
                } else {
                  setState(() => offset = maxOffset);
                }
              } else if (isOpen) {
                _animateTo(false);
              }
            },
            onDoubleTap: () => _animateTo(true),
            onLongPress: () => _animateTo(!isOpen),
            onHorizontalDragCancel: () => _animateTo(false),
            onHorizontalDragEnd: (details) {
              if (offset > maxOffset || widget.resetOnRelease) {
                _animateTo(false);
              }
              if (offset <= maxOffset) {
                widget.onStateChanged?.call(isOpen = true);
              }
            },
            child: Transform.translate(
              offset: Offset(offset, 0),
              child: widget.child,
            ),
          )
        else
          widget.child,
      ],
    );
  }
}
