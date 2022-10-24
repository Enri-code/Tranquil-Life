import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/core/utils/services/formatters.dart';
import 'package:tranquil_life/features/chat/domain/repos/audio_recorder.dart';

class AudioRecorder extends IAudioRecorder {
  static final sessionConfig = AudioSessionConfiguration(
    avAudioSessionCategory: AVAudioSessionCategory.record,
    avAudioSessionCategoryOptions:
        AVAudioSessionCategoryOptions.allowBluetooth |
            AVAudioSessionCategoryOptions.defaultToSpeaker,
    avAudioSessionMode: AVAudioSessionMode.spokenAudio,
    avAudioSessionRouteSharingPolicy:
        AVAudioSessionRouteSharingPolicy.defaultPolicy,
    avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
    androidAudioAttributes: const AndroidAudioAttributes(
      contentType: AndroidAudioContentType.speech,
      flags: AndroidAudioFlags.none,
      usage: AndroidAudioUsage.voiceCommunication,
    ),
    androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    androidWillPauseWhenDucked: true,
  );

  final controller = FlutterSoundRecorder();

  final _durTextStream = StreamController<String>.broadcast();
  Stream<String> get onDurationText => _durTextStream.stream;

  StreamSubscription? _durationStreamSub;
  String _filePath = '${uidGenerator.v4()}.aac';

  @override
  Future init() async {
    super.init();
    _durTextStream.add('00:00');
    if (!kIsWeb) await Permission.microphone.request();
    controller.openRecorder().then((_) {
      return controller.setSubscriptionDuration(
        const Duration(milliseconds: 500),
      );
    });
    AudioSession.instance.then((value) => value.configure(sessionConfig));
  }

  @override
  Future start() async {
    super.start();
    _durTextStream.add('00:00');
    await controller.startRecorder(codec: Codec.aacMP4, toFile: _filePath);
    _durationStreamSub = controller.onProgress?.listen((event) {
      _durTextStream.add(TimeFormatter.toTimerString(
        event.duration.inMilliseconds,
      ));
    });
  }

  @override
  Future cancel() async {
    super.cancel();
    _durTextStream.add('00:00');
    await controller.deleteRecord(fileName: _filePath);
  }

  @override
  Future<File?> stop() async {
    super.stop();
    _durTextStream.add('00:00');
    final path = await controller.stopRecorder();
    _filePath = '${uidGenerator.v4()}.aac';
    // textController.clear();
    if (path == null) return null;
    return File(path);
  }

  @override
  void dispose() {
    super.dispose();
    _durationStreamSub?.cancel();
    _durTextStream.close();
    controller.closeRecorder();
  }
}
