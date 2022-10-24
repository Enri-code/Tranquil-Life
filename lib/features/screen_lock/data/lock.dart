import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/features/screen_lock/data/screen_lock_store.dart';
import 'package:tranquil_life/features/screen_lock/domain/lock.dart';
import 'package:tranquil_life/features/screen_lock/presentation/screens/lock_screen.dart';

class ScreenLock extends IScreenLock {
  final _auth = LocalAuthentication();

  NavigatorState? _navigator;
  Timer? _timer;

  @override
  Future init(NavigatorState navigator) {
    _navigator = navigator;
    return lockController.init();
  }

  @override
  void startTimer() {
    _timer = Timer(const Duration(minutes: 3), () async {
      if (await lockController.hasSetupPin && _timer != null) {
        bool showLock = true;
        if (lockController.canUseDeviceAuth) {
          showLock = !await _tryDeviceAuth();
        }
        if (showLock) await _showLockScreen(LockType.authenticate, false);
      }
      resetTimer();
    });
  }

  @override
  void stopTimer() {
    _timer?.cancel();
    _timer == null;
  }

  @override
  void resetTimer() {
    stopTimer();
    startTimer();
  }

  Future<bool> _tryDeviceAuth() {
    const options =
        AuthenticationOptions(biometricOnly: true, stickyAuth: true);
    return _auth
        .authenticate(
          localizedReason: 'Please authenticate to access ${AppConfig.appName}',
          options: options,
        )
        .catchError((_, __) => false);
  }

  Future<bool?> _showLockScreen(LockType lockType,
      [bool setupIfUnset = true]) async {
    if ((lockType == LockType.authenticate || lockType == LockType.resetPin) &&
        !(await lockController.hasSetupPin)) {
      if (!setupIfUnset) return true;
      lockType = LockType.setupPin;
    }

    final result = await _navigator!.pushNamed(
      LockScreen.routeName,
      arguments: lockType,
    );
    return result as bool?;
  }

  @override
  Future<bool> showLock([LockType lockType = LockType.authenticate]) async {
    if (lockType == LockType.authenticate && lockController.canUseDeviceAuth) {
      if (await _tryDeviceAuth()) return true;
    }

    return await _showLockScreen(lockType) ?? false;
  }

  @override
  Future<void> clear() => lockController.clear();

  @override
  Future<void> setDeviceAuthUnlock(bool val) =>
      lockController.setDeviceAuthUnlock(val);
}
