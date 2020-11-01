abstract class SharedData {
  add(String key, dynamic value);

  Future<dynamic> get(String key);

  Future remove(String key);

  Future<bool> hasKey(String key);
}
