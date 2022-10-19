import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';

class SmallView extends StatefulWidget {
  const SmallView({
    Key? key,
    required this.channelId,
    this.onPlatformViewCreated,
    this.onDoubleTap,
    this.isLocal = true,
  }) : super(key: key);

  final bool isLocal;
  final String channelId;
  final Function()? onDoubleTap;
  final Function(int)? onPlatformViewCreated;

  @override
  State<SmallView> createState() => _SmallViewState();
}

class _SmallViewState extends State<SmallView> {
  Widget _viewBuilder() {
    return const SizedBox();
    /*  return AgoraVideoView(
      controller: ,
    ); */
  }

  @override
  Widget build(BuildContext context) {
    final screenSize =
        MediaQuery.of(context).padding.deflateSize(MediaQuery.of(context).size);
    final size = Size(0.21 * screenSize.width, 0.2 * screenSize.height);
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          DraggableWidget(
            topMargin: 48,
            horizontalSpace: 12,
            initialPosition: AnchoringPosition.bottomRight,
            statusBarHeight: MediaQuery.of(context).viewPadding.top,
            bottomMargin: size.height * 0.5 +
                MediaQuery.of(context).viewPadding.bottom +
                80,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(3),
              child: SizedBox.fromSize(
                size: size,
                child: GestureDetector(
                  onDoubleTap: widget.onDoubleTap,
                  child: Container(color: Colors.white, child: _viewBuilder()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
