import 'package:hive_flutter/hive_flutter.dart';
import 'package:tranquil_life/features/auth/data/models/client_model.dart';
import 'package:tranquil_life/features/auth/domain/entities/client.dart';

abstract class _Store {
  static Box? _box;
  static Future init() async => _box ??= await Hive.openBox('app_data');

  static T? get<T>(String key, {T? defaultValue}) =>
      _box!.get(key) ?? defaultValue;

  static Future set(String key, dynamic value) => _box!.put(key, value);
  //static Future delete(String key) => _box.delete(key);
  static Future deleteAll(List<String> keys) => _box!.deleteAll(keys);
}

abstract class _Keys {
  static const user = 'user';
  static const isSignedIn = 'isSignedIn';
  static const isOnboardingCompleted = 'isOnboardingCompleted';
  static const hasAnsweredQuestions = 'hasAnsweredQuestions';
}

abstract class AppData {
  static Future init() => _Store.init();

  static bool get isOnboardingCompleted =>
      _Store.get(_Keys.isOnboardingCompleted, defaultValue: false)!;
  static set isOnboardingCompleted(bool val) =>
      _Store.set(_Keys.isOnboardingCompleted, val);

  static bool get hasAnsweredQuestions =>
      _Store.get(_Keys.hasAnsweredQuestions, defaultValue: false)!;
  static set hasAnsweredQuestions(bool val) =>
      _Store.set(_Keys.hasAnsweredQuestions, val);

  static Client? get user {
    var val = _Store.get(_Keys.user);
    if (val == null) return null;
    return ClientModel.fromJson(val);
  }

  static set user(Client? val) => _Store.set(_Keys.user, val?.toJson());

  static bool get isSignedIn => _Store.get(
        _Keys.isSignedIn,
        defaultValue: false,
      )!;

  static Future deleteUser() =>
      _Store.deleteAll([_Keys.user, _Keys.isSignedIn]);
}
