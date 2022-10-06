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
  void init(NavigatorState navigator) => _navigator = navigator;

  @override
  void resetTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(minutes: 5), () {
      _showLockScreen(LockType.authenticate, false);
    });
  }

  Future<bool?> _showLockScreen(LockType lockType,
      [bool setupIfUnset = true]) async {
    if (lockType == LockType.authenticate &&
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
    if (lockType == LockType.authenticate && await lockController.hasSetupPin) {
      final didAuthWithDevice = await _auth
          .authenticate(
            localizedReason:
                'Please authenticate to access ${AppConfig.appName}',
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
            ),
          )
          .catchError((_, __) => false);
      if (didAuthWithDevice) return true;
    }

    return await _showLockScreen(lockType) ?? false;
  }

  @override
  Future<void> clearPin() => lockController.clearPin();
}
