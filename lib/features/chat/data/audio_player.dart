import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:tranquil_life/core/utils/services/time_formatter.dart';
import 'package:tranquil_life/features/chat/domain/repos/audio_player.dart';

class AudioWavePlayer extends AudioPlayer {
  AudioWavePlayer();

  final _controller = PlayerController();
  final _durTextStream = StreamController<String>.broadcast();
  final _durPercentStream = StreamController<double>.broadcast();

  PlayerController get controller => _controller;

  StreamSubscription? _durationStreamSub;

  Stream<PlayerState> get onStateChanged => _controller.onPlayerStateChanged;

  @override
  Stream<double> get onDurationPercent => _durPercentStream.stream;

  @override
  Stream<String> get onDurationText => _durTextStream.stream;

  @override
  Future seekTo(int milliseconds) => _controller.seekTo(milliseconds);

  @override
  Future seekToPercent(double percent) {
    return seekTo((percent * _controller.maxDuration).round());
  }

  @override
  Future init(String path) async {
    await _controller.preparePlayer(path);
    _durationStreamSub = _controller.onCurrentDurationChanged.listen((event) {
      _durPercentStream.add(event / _controller.maxDuration);
      _durTextStream.add(TimeFormatter.toTimerString(event));
    });
    _durTextStream.add(TimeFormatter.toTimerString(_controller.maxDuration));
  }

  @override
  Future play() => _controller.startPlayer(finishMode: FinishMode.pause);

  @override
  Future pause() => _controller.pausePlayer();

  @override
  void dispose() {
    _durationStreamSub?.cancel();
    _durTextStream.close();
    _durPercentStream.close();
    _controller.dispose();
  }
}