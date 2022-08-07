import 'package:flutter/material.dart';

class SwipeableWidget extends StatefulWidget {
  const SwipeableWidget({
    Key? key,
    required this.child,
    this.swipedWidget,
    this.onStateChanged,
  }) : super(key: key);

  final Widget child;
  final Widget? swipedWidget;

  final Function(bool isOpen)? onStateChanged;

  @override
  State<SwipeableWidget> createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animator;

  bool isOpen = false;
  double offset = 0, initialOffset = 0, lastOffset = 0;
  late double maxOffset;

  @override
  void initState() {
    animator = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addListener(() {
        var toPosition = isOpen ? maxOffset : lastOffset;
        setState(() => offset = toPosition * animator.value);
      });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maxOffset = -MediaQuery.of(context).size.width * 0.15;
  }

  @override
  void dispose() {
    animator.dispose();
    super.dispose();
  }

  animateTo(bool end) {
    isOpen = end;
    widget.onStateChanged?.call(end);
    lastOffset = offset;
    if (end) {
      animator.forward(from: 0);
    } else {
      animator.reverse(from: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    var percentage = offset / maxOffset;
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        if (widget.swipedWidget != null)
          Transform.scale(
            scale: percentage * 0.3 + 0.7,
            child: Opacity(
              opacity: percentage.clamp(0, 1),
              child: Listener(
                onPointerDown: (_) => animateTo(false),
                behavior: HitTestBehavior.opaque,
                child: widget.swipedWidget!,
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            if (isOpen) animateTo(false);
          },
          onHorizontalDragStart: (details) =>
              initialOffset = details.localPosition.dx,
          onHorizontalDragUpdate: (details) {
            if (details.localPosition.dx < initialOffset) {
              if (offset > maxOffset) {
                if (isOpen) {
                  isOpen = false;
                  widget.onStateChanged?.call(false);
                }
                setState(() {
                  offset = details.localPosition.dx - initialOffset;
                });
              } else {
                if (!isOpen) {
                  isOpen = true;
                  widget.onStateChanged?.call(true);
                }
                setState(() => offset = maxOffset);
              }
            } else if (isOpen) {
              animateTo(false);
            }
          },
          onDoubleTap: () => animateTo(true),
          onLongPress: () => animateTo(!isOpen),
          onHorizontalDragCancel: () => animateTo(false),
          onHorizontalDragEnd: (details) {
            if (offset > maxOffset) animateTo(false);
          },
          child: Transform.translate(
            offset: Offset(offset, 0),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
