import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IStore {
  Future<void> init();
  T? get<T>(String key, {T? defaultValue});
  Future<void> set(String key, dynamic value);
  Future<void> deleteAll(List<String> keys);
}

class HiveStore extends IStore {
  HiveStore(this.key);
  final String? key;

  Box? _box;

  @override
  Future<void> init() async => _box ??= await Hive.openBox(key!);

  @override
  T? get<T>(String key, {T? defaultValue}) => _box!.get(key) ?? defaultValue;

  @override
  Future set(String key, dynamic value) => _box!.put(key, value);
  @override
  Future deleteAll(List<String> keys) => _box!.deleteAll(keys);
}

class SecuredHiveStore extends HiveStore {
  static const secureStorage = FlutterSecureStorage();
  SecuredHiveStore(String key) : super(key);

  @override
  Future init() async {
    if (_box != null) return;
    String? encryptionKey = await secureStorage.read(key: key!);
    if (encryptionKey == null) {
      encryptionKey = base64UrlEncode(Hive.generateSecureKey());
      secureStorage.write(key: 'key', value: encryptionKey);
    }
    _box = await Hive.openBox(
      key!,
      encryptionCipher: HiveAesCipher(base64Url.decode(encryptionKey)),
    );
  }
}
