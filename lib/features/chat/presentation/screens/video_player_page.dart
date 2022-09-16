import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';

class VideoPlayerData {
  const VideoPlayerData({this.videoUrl = '', this.isLocal = false});

  final bool isLocal;
  final String videoUrl;
}

class VideoPlayerScreen extends StatefulWidget {
  ///argument is [VideoPlayerData]
  static const routeName = 'video_player_screen';
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPLayerState();
}

class _VideoPLayerState extends State<VideoPlayerScreen> {
  late VideoPlayerData data;

  final controller = BetterPlayerController(const BetterPlayerConfiguration(
    autoPlay: true,
    fit: BoxFit.cover,
    autoDetectFullscreenDeviceOrientation: true,
  ));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as VideoPlayerData;
    final BetterPlayerDataSource source;
    if (data.isLocal) {
      source = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        data.videoUrl,
      );
    } else {
      source = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        data.videoUrl,
      );
    }
    controller.setupDataSource(source);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.black,
      body: BetterPlayer(controller: controller),
    );
  }
}
