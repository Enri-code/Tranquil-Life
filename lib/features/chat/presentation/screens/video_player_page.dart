import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';

class VideoPlayerPage extends StatefulWidget {
  final bool isLocal;
  final String videoUrl;

  const VideoPlayerPage({
    Key? key,
    this.videoUrl = '',
    this.isLocal = false,
  }) : super(key: key);

  @override
  _VideoPLayerState createState() => _VideoPLayerState();
}

class _VideoPLayerState extends State<VideoPlayerPage> {
  final controller = BetterPlayerController(const BetterPlayerConfiguration(
    autoPlay: true,
    fit: BoxFit.cover,
    autoDetectFullscreenDeviceOrientation: true,
  ));

  @override
  void initState() {
    super.initState();
    final BetterPlayerDataSource source;
    if (widget.isLocal) {
      source = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        widget.videoUrl,
      );
    } else {
      source = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.videoUrl,
      );
    }
    controller.setupDataSource(source);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.black,
      body: BetterPlayer(controller: controller),
      /* Stack(
        fit: StackFit.expand,
        children: [
          // BetterPlayer(controller: controller),
          /* Positioned(
            top: 12,
            left: 12,
            child: AppBarButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ), */
        ],
      ), */
    );
  }
}
