import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/lock/domain/lock.dart';
import 'package:tranquil_life/features/lock/presentation/widgets/footer.dart';
import 'package:tranquil_life/features/lock/presentation/widgets/title.dart';

class ScreenLock extends IScreenLock {
  static const pinStoreKey = 'lock_key';
  final _auth = LocalAuthentication();
  bool _isDeviceAuthAvailable = false;
  BuildContext? _context;

  Future<String?> _showPinScreen({
    bool isPinSetup = false,
    String correctPin = '',
  }) async {
    String? inputPin;
    _continue(String val) async {
      inputPin = val;
      await Future.delayed(const Duration(milliseconds: 50));
      Navigator.of(_context!).pop();
    }

    final controller = InputController();
    await screenLock(
      context: _context!,
      canCancel: false,
      maxRetries: 3,
      retryDelay: const Duration(minutes: 5),
      confirmation: isPinSetup,
      correctString: correctPin,
      inputController: isPinSetup ? controller : null,
      didConfirmed: isPinSetup ? _continue : null,
      didUnlocked: isPinSetup ? null : () => _continue(''),
      title: LockTitleWidget(isPinSetup: isPinSetup),
      confirmTitle: const Text('Please re-enter the same pin'),
      footer: Footer(isPinSetup, controller: controller),
    );
    return inputPin;
  }

  @override
  Future init(BuildContext context) async {
    _context = context;
    final availableBios = await _auth.getAvailableBiometrics();
    _isDeviceAuthAvailable = availableBios.isNotEmpty;
  }

  @override
  Future<bool> authenticate({String? reason, bool setupIfNull = false}) async {
    if (_isDeviceAuthAvailable) {
      assert(
        _context != null,
        'init() needs to be called before the authenticate function can be used',
      );

      final authReason =
          reason ?? 'Please authenticate to access ${AppConfig.appName}';

      try {
        final didAuthWithBios = await _auth.authenticate(
          localizedReason: authReason,
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
        if (didAuthWithBios) return true;
      } on PlatformException catch (_) {
        final didAuth = await _auth
            .authenticate(
              localizedReason: authReason,
              options: const AuthenticationOptions(
                useErrorDialogs: false,
                stickyAuth: true,
              ),
            )
            .onError((_, __) => false);
        if (didAuth) return true;
      }
    }
    final key = await secureStore.read(key: pinStoreKey);
    if (key != null) {
      return (await _showPinScreen(correctPin: key)) != null;
    } else if (setupIfNull) {
      return setupPin();
    } else {
      return true;
    }
  }

  @override
  Future<bool> setupPin() async {
    final key = (await _showPinScreen(isPinSetup: true))!;
    secureStore.write(key: pinStoreKey, value: key);
    return key.isNotEmpty;
  }

  @override
  Future<void> clearPin() => secureStore.delete(key: pinStoreKey);
}
