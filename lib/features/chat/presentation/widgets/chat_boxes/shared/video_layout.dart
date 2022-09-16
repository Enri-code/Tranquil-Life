import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/core/utils/services/media_service.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/presentation/screens/video_player_page.dart';

class VideoLayout extends StatefulWidget {
  const VideoLayout({Key? key, required this.message}) : super(key: key);
  final Message message;

  static Future<File?> getVideoThumb(String url,
      [bool fromFile = false]) async {
    return (await DefaultCacheManager().getFileFromCache(url))?.file ??
        await MediaService.generateVideoThumb(url, fromFile: fromFile);
  }

  @override
  State<VideoLayout> createState() => _VideoLayoutState();
}

class _VideoLayoutState extends State<VideoLayout> {
  static final _errorWidget = Container(
    color: Colors.grey[300],
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.videocam_off_outlined, color: Colors.grey[700], size: 80),
          Text(
            'Preview unavailable',
            style: TextStyle(color: Colors.grey[800]!, fontSize: 18),
          ),
        ],
      ),
    ),
  );

  File? thumbFile;

  Future _generateThumb() async {
    final file = await VideoLayout.getVideoThumb(
      widget.message.data,
      !widget.message.isSent,
    );
    setState(() => thumbFile = file ?? File(''));
    if (thumbFile!.path.isNotEmpty) {
      DefaultCacheManager().putFile(
        thumbFile!.path,
        await thumbFile!.readAsBytes(),
        key: widget.message.data,
        maxAge: const Duration(hours: 6),
        fileExtension: 'jpg',
      );
    }
  }

  @override
  void initState() {
    _generateThumb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.6,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          VideoPlayerScreen.routeName,
          arguments: VideoPlayerData(
            videoUrl: widget.message.data,
            isLocal: !widget.message.isSent,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            if (thumbFile == null)
              CustomLoader.widget(Colors.white)
            else
              Image.file(
                thumbFile!,
                fit: BoxFit.cover,
                frameBuilder: (_, child, frame, __) {
                  return frame == null ? const SizedBox() : child;
                },
                errorBuilder: (_, __, ___) => _errorWidget,
              ),
            if (thumbFile != null)
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white70,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.black87,
                    size: 60,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
