import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tranquil_life/core/constants/constants.dart';

import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/screens/video_player_page.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_boxes/sender_box_base.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/replied_chat_box.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SenderChatVideo extends StatefulWidget {
  const SenderChatVideo(this.message, {Key? key}) : super(key: key);

  final Message message;

  @override
  State<SenderChatVideo> createState() => _SenderChatVideoState();
}

class _SenderChatVideoState extends State<SenderChatVideo> {
  static final _errorWidget = Container(
    color: Colors.grey[300],
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.videocam_off_outlined,
            color: Colors.grey[700],
            size: 80,
          ),
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
        quality: 75,
        imageFormat: ImageFormat.JPEG,
        maxHeight: chatBoxMaxWidth.round(),
        video: widget.message.data,
      );

      setState(() {
        thumbFile = file == null ? File('') : File.fromRawPath(file);
      });
    }
    if (thumbFile!.path.isNotEmpty) {
      DefaultCacheManager().putFile(
        widget.message.data,
        await thumbFile!.readAsBytes(),
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
    return SenderChatBoxBase(
      time: widget.message.timeSent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.message is ReplyMessage)
            RepliedChatBox(
              widget.message as ReplyMessage,
              backgroundColor: Color.lerp(
                Colors.black,
                Theme.of(context).primaryColor,
                0.82,
              )!,
            ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.6,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => VideoPlayerPage(
                  videoUrl: widget.message.data,
                  isLocal: !widget.message.isSent,
                ),
              )),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: widget.message.data,
                    child: Builder(builder: (_) {
                      if (thumbFile == null) {
                        return CustomLoader.widget(Colors.white);
                      }
                      return Image.file(
                        thumbFile!,
                        fit: BoxFit.cover,
                        frameBuilder: (_, Widget child, int? frame, __) {
                          if (frame == null) {
                            return CustomLoader.widget(Colors.white);
                          }
                          return child;
                        },
                        errorBuilder: (_, __, ___) => _errorWidget,
                      );
                    }),
                  ),
                  if (thumbFile != null)
                    const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.black87,
                      size: 80,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
