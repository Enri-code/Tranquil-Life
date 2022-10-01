const keyPadSize = 68.0;

abstract class IScreenLockController {
  Future<void> clearPin();
  Future<String?> getPin();
  Future<void> setPin(String val);
}
