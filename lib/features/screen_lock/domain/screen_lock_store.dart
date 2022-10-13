const double keyPadSize = 72.0;

abstract class IScreenLockController {
  Future<bool> get hasSetupPin;
  bool get canUseDeviceAuth;

  int? get tries;
  set tries(int? val);

  Future<DateTime?> get timeOfLock;

  Future init();
  Future<String?> getPin();
  Future<void> setPin(String val);
  Future<void> setDeviceAuthUnlock(bool val);
  Future<void> clear();
  Future<void> lockInput();
}
