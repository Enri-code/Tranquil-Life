import 'package:tranquil_life/features/store/data/store.dart';
import 'package:tranquil_life/features/store/domain/store.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/screen_lock/domain/screen_lock_store.dart';

IScreenLockController lockController = ScreenLockController();

abstract class _Keys {
  static const _pinStoreKey = 'pin_store';

  static const _triesKey = 'tries_store';
  static const _lockTimeKey = 'lock_time_store';
  static const _canUseDeviceAuth = '_canUseDeviceAuth';
}

class ScreenLockController extends IScreenLockController {
  ScreenLockController();

  bool? _hasSetupPin;

  final IStore _store = HiveStore('screen_lock');

  @override
  Future<bool> get hasSetupPin async => _hasSetupPin ??= await getPin() != null;

  @override
  bool get canUseDeviceAuth => _store.get(_Keys._canUseDeviceAuth) ?? false;

  @override
  int? get tries => _store.get(_Keys._triesKey);

  @override
  set tries(int? tries) => _store.set(_Keys._triesKey, tries);

  @override
  Future<DateTime?> get timeOfLock async {
    final millis = await _store.get(_Keys._lockTimeKey);
    if (millis == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  @override
  Future init() => _store.init();

  @override
  Future<String?> getPin() => secureStore.read(key: _Keys._pinStoreKey);

  @override
  Future<void> setPin(String val) async {
    _hasSetupPin = true;
    await secureStore.write(key: _Keys._pinStoreKey, value: val);
  }

  @override
  Future<void> clear() async {
    _hasSetupPin = false;
    await Future.wait(
      [_store.deleteAll(), secureStore.delete(key: _Keys._pinStoreKey)],
    );
  }

  @override
  Future<void> lockInput() async {
    tries = null;
    await _store.set(_Keys._lockTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<void> setDeviceAuthUnlock(bool val) =>
      _store.set(_Keys._canUseDeviceAuth, val);
}
