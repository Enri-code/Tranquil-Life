import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/chat_boxes/sender_boxes/sender_box_base.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/replied_chat_box.dart';

class SenderChatVoiceNote extends StatefulWidget {
  const SenderChatVoiceNote(this.message, {Key? key}) : super(key: key);
  final Message message;

  @override
  State<SenderChatVoiceNote> createState() => _SenderChatVoiceNoteState();
}

class _SenderChatVoiceNoteState extends State<SenderChatVoiceNote>
    with SingleTickerProviderStateMixin {
  static final audioWidgetSize = Size(chatBoxMaxWidth - 90, 48);

  final player = PlayerController();
  late final AnimationController playAnimController;

  bool loadingAudio = true;
  String durationText = '---:---';
  StreamSubscription? durationStream, playStateStream;

  Future _prepareAudio() async {
    String path;
    if (widget.message.isSent) {
      var file = await DefaultCacheManager().getSingleFile(widget.message.data);
      path = file.path;
    } else {
      path = widget.message.data;
    }
    await player.preparePlayer(path);
    playStateStream = player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.paused) {
        playAnimController.reverse();
      } else if (event == PlayerState.playing) {
        playAnimController.forward();
      }
    });
    durationStream = player.onCurrentDurationChanged.listen((event) {
      setState(() => durationText = formatDurationToTimerString(event));
    });
    setState(() {
      loadingAudio = false;
      durationText = formatDurationToTimerString(player.maxDuration);
    });
  }

  @override
  void initState() {
    super.initState();
    playAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );
    _prepareAudio();
  }

  @override
  void dispose() {
    player.dispose();
    playAnimController.dispose();
    durationStream?.cancel();
    playStateStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SenderChatBoxBase(
      time: widget.message.timeSent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.all(1),
            child: Row(
              children: [
                if (loadingAudio)
                  SizedBox(
                    height: audioWidgetSize.height,
                    child: Row(
                      children: [
                        const SizedBox(width: 4),
                        const SizedBox.square(
                          dimension: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        DottedLine(lineLength: audioWidgetSize.width - 6),
                      ],
                    ),
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (playAnimController.isDismissed) {
                            player.startPlayer(finishMode: FinishMode.pause);
                          } else {
                            player.pausePlayer();
                          }
                        },
                        child: AnimatedIcon(
                          size: 28,
                          color: Colors.white,
                          icon: AnimatedIcons.play_pause,
                          progress: playAnimController,
                        ),
                      ),
                      AudioFileWaveforms(
                        density: 0.4,
                        playerController: player,
                        size: audioWidgetSize,
                        playerWaveStyle: const PlayerWaveStyle(
                          waveThickness: 1.4,
                          fixedWaveColor: Colors.white38,
                          liveWaveColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                Text(
                  durationText,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
