import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/chat/data/audio_player.dart';
import 'package:tranquil_life/features/chat/domain/entities/message.dart';

class VoiceNoteLayout extends StatefulWidget {
  const VoiceNoteLayout({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  State<VoiceNoteLayout> createState() => _VoiceNoteLayoutState();
}

class _VoiceNoteLayoutState extends State<VoiceNoteLayout>
    with SingleTickerProviderStateMixin {
  static final audioWidgetSize = Size(chatBoxMaxWidth - 82, 48);

  final audioPlayer = AudioWavePlayer();

  late final AnimationController playAnimController;
  StreamSubscription? _playStateStreamSub;

  bool loadingAudio = true;

  Future _preparePlayer() async {
    late final String path;
    if (widget.message.isSent) {
      var file = await DefaultCacheManager().getSingleFile(widget.message.data);
      path = file.path;
    } else {
      path = widget.message.data;
    }
    await audioPlayer.init(path);
    setState(() => loadingAudio = false);
    _playStateStreamSub = audioPlayer.onStateChanged.listen((event) {
      if (event == PlayerState.paused) {
        playAnimController.reverse();
      } else if (event == PlayerState.playing) {
        playAnimController.forward();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    playAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );
    _preparePlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    playAnimController.dispose();
    _playStateStreamSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Row(
        children: [
          Expanded(
            child: Builder(
              builder: (_) {
                if (loadingAudio) {
                  return SizedBox(
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
                        DottedLine(
                          lineLength: audioWidgetSize.width - 6,
                          dashColor: widget.message.fromYou
                              ? Colors.white
                              : Colors.black,
                        ),
                      ],
                    ),
                  );
                }
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (playAnimController.isDismissed) {
                          audioPlayer.play();
                        } else {
                          audioPlayer.pause();
                        }
                      },
                      child: AnimatedIcon(
                        size: 28,
                        color: widget.message.fromYou
                            ? Colors.white
                            : Colors.black,
                        icon: AnimatedIcons.play_pause,
                        progress: playAnimController,
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AudioFileWaveforms(
                            density: 0.4,
                            size: audioWidgetSize,
                            enableSeekGesture: false,
                            playerController: audioPlayer.controller,
                            playerWaveStyle: PlayerWaveStyle(
                              waveThickness: 1.4,
                              liveWaveColor: widget.message.fromYou
                                  ? Colors.white
                                  : Colors.black,
                              fixedWaveColor: widget.message.fromYou
                                  ? Colors.white38
                                  : Colors.black38,
                            ),
                          ),
                          if (androidVersion == null || androidVersion! > 8.1)
                            Positioned.fill(
                              child: StreamBuilder<double>(
                                initialData: 0,
                                stream: audioPlayer.onDurationPercent,
                                builder: (context, snapshot) {
                                  return _Slider(
                                    value: snapshot.data!,
                                    fromYou: widget.message.fromYou,
                                    onValueChanged: (val) async {
                                      await audioPlayer.seekToPercent(val);
                                      audioPlayer.play();
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          StreamBuilder<String>(
            initialData: '---:---',
            stream: audioPlayer.onDurationText,
            builder: (context, snapshot) {
              return Text(
                snapshot.data!,
                style: TextStyle(
                  fontSize: 12,
                  color: widget.message.fromYou ? Colors.white : Colors.black,
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _Slider extends StatefulWidget {
  const _Slider({
    Key? key,
    required this.onValueChanged,
    required this.fromYou,
    this.value = 0,
  }) : super(key: key);

  final double value;
  final bool fromYou;
  final Function(double value) onValueChanged;

  @override
  State<_Slider> createState() => _SliderState();
}

class _SliderState extends State<_Slider> {
  late double value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _Slider oldWidget) {
    setState(() => value = widget.value);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 0,
        overlayShape: SliderComponentShape.noOverlay,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
        thumbColor: widget.fromYou ? Colors.white : Colors.black,
      ),
      child: Slider(
        value: value,
        onChanged: (val) {
          setState(() => value = val);
          widget.onValueChanged(val);
        },
      ),
    );
  }
}
