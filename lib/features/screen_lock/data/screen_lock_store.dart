import 'package:tranquil_life/app/data/repos/store.dart';
import 'package:tranquil_life/app/domain/repos/store.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/screen_lock/domain/screen_lock_store.dart';

IScreenLockController lockController = ScreenLockController()..init();

abstract class _Keys {
  static const _pinStoreKey = 'pin_store';
  static const _triesKey = 'tries_store';
  static const _lockTimeKey = 'lock_time_store';
}

class ScreenLockController extends IScreenLockController {
  ScreenLockController();

  bool? _hasSetupPin;

  final IStore _store = HiveStore('screen_lock');

  @override
  Future<bool> get hasSetupPin async => _hasSetupPin ??= await getPin() != null;

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
  Future<void> clearPin() {
    _hasSetupPin = false;
    return secureStore.delete(key: _Keys._pinStoreKey);
  }

  @override
  Future<DateTime?> get timeOfLock async {
    final millis = await _store.get(_Keys._lockTimeKey);
    if (millis == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  @override
  int? get tries => _store.get(_Keys._triesKey);

  @override
  set tries(int? tries) => _store.set(_Keys._triesKey, tries);

  @override
  Future<void> lockInput() async {
    tries = null;
    await _store.set(_Keys._lockTimeKey, DateTime.now().millisecondsSinceEpoch);
  }
}
