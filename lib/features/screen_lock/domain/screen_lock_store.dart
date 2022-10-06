const keyPadSize = 68.0;

abstract class IScreenLockController {
  Future<bool> get hasSetupPin;

  int? get tries;
  set tries(int? val);

  Future<DateTime?> get timeOfLock;

  Future init();
  Future<String?> getPin();
  Future<void> setPin(String val);
  Future<void> clearPin();
  Future<void> lockInput();
}
