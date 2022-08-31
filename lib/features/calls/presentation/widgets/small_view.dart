import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as local;

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
    return local.SurfaceView(
      zOrderOnTop: true,
      zOrderMediaOverlay: true,
      channelId: widget.channelId,
      onPlatformViewCreated: widget.onPlatformViewCreated,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize =
        MediaQuery.of(context).padding.deflateSize(MediaQuery.of(context).size);
    final size = Size(0.21 * screenSize.width, 0.2 * screenSize.height);
    return SafeArea(
      child: Stack(
        children: [
          DraggableWidget(
            horizontalSpace: 12,
            topMargin: 48,
            bottomMargin: size.height * 0.5 + 48,
            statusBarHeight: MediaQuery.of(context).viewPadding.top,
            initialPosition: AnchoringPosition.bottomRight,
            child: SizedBox.fromSize(
              size: size,
              child: GestureDetector(
                onDoubleTap: widget.onDoubleTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: _viewBuilder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
