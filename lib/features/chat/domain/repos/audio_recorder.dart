import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

abstract class IAudioRecorder {
  final _isRecordingStream = StreamController<bool>();

  Stream<bool> get omRecordingState => _isRecordingStream.stream;

  @mustCallSuper
  Future init() async {
    _isRecordingStream.add(false);
  }

  @mustCallSuper
  Future start() async {
    _isRecordingStream.add(true);
  }

  @mustCallSuper
  Future cancel() async {
    _isRecordingStream.add(false);
  }

  @mustCallSuper
  Future<File?> stop() async {
    _isRecordingStream.add(false);
    return null;
  }

  @mustCallSuper
  void dispose() => _isRecordingStream.close();
}
