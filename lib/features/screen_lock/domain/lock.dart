import 'package:flutter/material.dart';

enum LockType { setupPin, authenticate, resetPin }

abstract class IScreenLock {
  Future init(NavigatorState navigator);
  void startTimer();
  void resetTimer();
  void stopTimer();
  Future<void> clear();
  Future<void> setDeviceAuthUnlock(bool val);
  Future<bool> showLock([LockType lockType = LockType.authenticate]);
}
