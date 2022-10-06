import 'package:flutter/material.dart';

enum LockType { setupPin, authenticate, resetPin }

abstract class IScreenLock {
  void init(NavigatorState navigator);
  void resetTimer();
  Future<void> clearPin();
  Future<bool> showLock([LockType lockType = LockType.authenticate]);
}
