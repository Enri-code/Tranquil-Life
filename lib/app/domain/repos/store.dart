abstract class IStore {
  Future<void> init();
  T? get<T>(String key, {T? defaultValue});
  Future<void> set<T>(String key, T value);
  Future<void> deleteAll({List<String>? keys, bool closeBox = false});
}
