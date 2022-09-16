import 'package:flutter/material.dart';

abstract class IScreenLock {
  Future init(BuildContext context);
  Future authenticate([String? reason]);
  Future<bool> setupPin();
  Future<void> clearPin();
}
