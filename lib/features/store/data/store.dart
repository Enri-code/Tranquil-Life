import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/store/domain/store.dart';

class HiveStore extends IStore {
  HiveStore(this.key);
  final String key;

  Box? _box;

  @override
  Future<void> init() async => _box ??= await Hive.openBox(key);

  @override
  T? get<T>(String key, {T? defaultValue}) => _box?.get(key) ?? defaultValue;

  @override
  Future<void> set<T>(String key, T value) async => _box?.put(key, value);

  @override
  Future<void> deleteAll({List<String>? keys, bool closeBox = false}) async {
    await (keys == null ? _box?.clear() : _box?.deleteAll(keys));
    if (closeBox) return _box?.close();
  }
}

class SecuredHiveStore extends HiveStore {
  SecuredHiveStore(String key) : super(key);

  @override
  Future init() async {
    if (_box != null) return;
    final secureStoreKey = 'hive-$key';
    String? encryptionKey = await secureStore.read(key: secureStoreKey);
    if (encryptionKey == null) {
      encryptionKey = base64UrlEncode(Hive.generateSecureKey());
      secureStore.write(key: secureStoreKey, value: encryptionKey);
    }
    _box = await Hive.openBox(
      key,
      encryptionCipher: HiveAesCipher(base64Url.decode(encryptionKey)),
    );
  }
}
