import 'package:flutter/material.dart';

enum LockType { setupPin, authenticate, resetPin }

abstract class IScreenLock {
  Future init(NavigatorState navigator);
  Future<void> clearPin();
  Future<bool> showLock([LockType lockType = LockType.authenticate]);
}
