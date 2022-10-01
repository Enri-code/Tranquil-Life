import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/screen_lock/domain/screen_lock_store.dart';

IScreenLockController lockController = ScreenLockController();

class ScreenLockController extends IScreenLockController {
  static const _pinStoreKey = 'pin_store';

  @override
  Future<void> clearPin() => secureStore.delete(key: _pinStoreKey);

  @override
  Future<String?> getPin() => secureStore.read(key: _pinStoreKey);

  @override
  Future<void> setPin(String val) {
    return secureStore.write(key: _pinStoreKey, value: val);
  }
}
