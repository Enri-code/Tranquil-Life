import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/presentation/screens/video_player_page.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoLayout extends StatefulWidget {
  const VideoLayout({Key? key, required this.message}) : super(key: key);
  final Message message;

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
            'Video unavailable',
            style: TextStyle(color: Colors.grey[800]!, fontSize: 18),
          ),
        ],
      ),
    ),
  );

  File? thumbFile;

  Future _generateThumb() async {
    var cachedFile = await DefaultCacheManager().getFileFromCache(
      widget.message.data,
    );
    if (cachedFile != null) {
      setState(() => thumbFile = cachedFile.file);
      return;
    }
    if (widget.message.isSent) {
      final fileName = await VideoThumbnail.thumbnailFile(
        quality: 75,
        imageFormat: ImageFormat.JPEG,
        maxHeight: chatBoxMaxWidth.round(),
        video: widget.message.data,
      );
      setState(() => thumbFile = File(fileName ?? ''));
    } else {
      final file = await VideoThumbnail.thumbnailData(
        maxHeight: chatBoxMaxWidth.round(),
        imageFormat: ImageFormat.JPEG,
        quality: 75,
        video: widget.message.data,
      );
      setState(() {
        thumbFile = file == null ? File('') : File.fromRawPath(file);
      });
    }
    if (thumbFile!.path.isNotEmpty) {
      DefaultCacheManager().putFile(
        thumbFile!.path,
        await thumbFile!.readAsBytes(),
        key: widget.message.data,
        maxAge: const Duration(hours: 1),
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
