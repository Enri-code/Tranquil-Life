import 'package:flutter/material.dart';

abstract class IScreenLock {
  Future init(BuildContext context);
  Future<bool> authenticate({String? reason, bool setupIfNull = false});
  Future<bool> setupPin();
  Future<void> clearPin();
}
