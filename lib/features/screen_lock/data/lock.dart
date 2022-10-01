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
  bool _isDeviceAuthAvailable = false;
  NavigatorState? _navigator;

  @override
  Future init(NavigatorState navigator) async {
    _navigator = navigator;
    _isDeviceAuthAvailable = (await _auth.getAvailableBiometrics()).isNotEmpty;
  }

  Future<bool> _tryDeviceAuth() async {
    assert(
      _navigator != null,
      'init() needs to be called before the authenticate function can be used',
    );

    const reason = 'Please authenticate to access ${AppConfig.appName}';
    bool didAuth = await _auth
        .authenticate(
          localizedReason: reason,
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            biometricOnly: true,
            stickyAuth: true,
          ),
        )
        .catchError((_, __) => false);
    if (didAuth) return true;
    didAuth = await _auth
        .authenticate(
          localizedReason: reason,
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: true,
          ),
        )
        .catchError((_, __) => false);
    if (didAuth) return true;
    return false;
  }

  @override
  Future<bool> showLock([LockType lockType = LockType.authenticate]) async {
    late bool hasSetupPin;
    bool didAuthWithDevice = false;

    await Future.wait([
      if (_isDeviceAuthAvailable && lockType == LockType.authenticate)
        _tryDeviceAuth().then((value) => didAuthWithDevice = value),
      lockController.getPin().then((value) => hasSetupPin = value != null)
    ]);

    if (didAuthWithDevice) return true;
    if (lockType == LockType.authenticate && !hasSetupPin) {
      lockType = LockType.setupPin;
    }
    final result = await _navigator!.pushNamed(
      LockScreen.routeName,
      arguments: lockType,
    );

    return result as bool? ?? false;
  }

  @override
  Future<void> clearPin() => lockController.clearPin();
}
