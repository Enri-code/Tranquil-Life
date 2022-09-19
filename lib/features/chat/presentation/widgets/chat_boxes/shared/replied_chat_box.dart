import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/core/utils/services/time_formatter.dart';
import 'package:tranquil_life/features/chat/data/samples.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/chat_box.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/shared/video_layout.dart';

class RepliedChatBox extends StatelessWidget {
  const RepliedChatBox(
    this.message, {
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  final Color backgroundColor;
  final ReplyMessage message;

  Widget _message(ReplyMessage message) {
    switch (message.repliedMessage.type) {
      case MessageType.image:
      case MessageType.video:
      case MessageType.voiceNote:
        return _MediaReplyWidget(message: message);
      default:
        return Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(fromYou: message.fromYou),
              const SizedBox(height: 3),
              Text(message.repliedMessage.data),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Stack(
        children: [
          ChatBoxBase(
            padding: 4,
            heightScale: 0.9,
            color: backgroundColor,
            child: MyDefaultTextStyle(
              inherit: true,
              style: TextStyle(
                color: message.fromYou ? Colors.white : Colors.black,
              ),
              child: _message(message),
            ),
          ),
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: InkResponse(
                containedInkWell: true,
                highlightShape: BoxShape.rectangle,
                onTap: () {
                  final replyIndex = messages.indexOf(message.repliedMessage);
                  if (replyIndex < 0) return;
                  context.read<ChatBloc>().add(ScrollToChatEvent(replyIndex));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaReplyWidget extends StatefulWidget {
  const _MediaReplyWidget({Key? key, required this.message}) : super(key: key);

  final ReplyMessage message;

  @override
  State<_MediaReplyWidget> createState() => _MediaReplyWidgetState();
}

class _MediaReplyWidgetState extends State<_MediaReplyWidget> {
  late final PlayerController player;
  String duration = '';

  Color get color =>
      widget.message.repliedMessage.fromYou ? Colors.white70 : Colors.black54;

  @override
  void initState() {
    if (widget.message.repliedMessage.type == MessageType.voiceNote) {
      _initAudio();
    }
    super.initState();
  }

  Future _initAudio() async {
    final String path;
    player = PlayerController();
    if (widget.message.repliedMessage.isSent) {
      final cachedFile = await DefaultCacheManager().getSingleFile(
        widget.message.repliedMessage.data,
      );
      path = cachedFile.path;
    } else {
      path = widget.message.repliedMessage.data;
    }
    await player.preparePlayer(path);
    setState(() => duration = TimeFormatter.toTimerString(player.maxDuration));
  }

  Widget _labelWidgetBuilder() {
    switch (widget.message.repliedMessage.type) {
      case MessageType.video:
        return _MediaWidget(text: 'Video', icon: Icons.image, color: color);
      case MessageType.voiceNote:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MediaWidget(text: 'Audio', icon: Icons.mic, color: color),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox.square(
                dimension: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Text(duration),
          ],
        );
      default:
        return _MediaWidget(text: 'Image', icon: Icons.image, color: color);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(fromYou: widget.message.fromYou),
                  const SizedBox(height: 2),
                  _labelWidgetBuilder(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          if (widget.message.repliedMessage.type != MessageType.voiceNote)
            SizedBox(
              width: 56,
              child: Builder(builder: (_) {
                if (widget.message.repliedMessage.type == MessageType.image) {
                  return Image.network(
                    widget.message.repliedMessage.data,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.broken_image_outlined,
                      color: color,
                      size: 40,
                    ),
                  );
                }
                return FutureBuilder<File?>(
                  future: VideoLayout.getVideoThumb(
                    widget.message.repliedMessage.data,
                    !widget.message.isSent,
                  ),
                  builder: (_, AsyncSnapshot<File?> snaoshot) {
                    if (snaoshot.data == null) {
                      return const Icon(Icons.video_file, size: 40);
                    }
                    return Image.file(snaoshot.data!, fit: BoxFit.cover);
                  },
                );
              }),
            ),
        ],
      ),
    );
  }
}

class _MediaWidget extends StatelessWidget {
  const _MediaWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 2),
        Text(text),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.fromYou}) : super(key: key);
  final bool fromYou;

  @override
  Widget build(BuildContext context) {
    return Text(
      fromYou ? 'You' : context.watch<ChatBloc>().state.consultant!.displayName,
      style: TextStyle(
        color: Color.lerp(
          Colors.white,
          Theme.of(context).primaryColor,
          fromYou ? 0.35 : 1,
        )!,
      ),
    );
  }
}
