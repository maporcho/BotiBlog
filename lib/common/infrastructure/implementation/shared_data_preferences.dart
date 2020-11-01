import 'package:shared_preferences/shared_preferences.dart';

import '../shared_data.dart';

class SharedDataPreferences extends SharedData {
  add(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value.runtimeType == int) {
      prefs.setInt(key, value);
    }
    if (value.runtimeType == double) {
      prefs.setDouble(key, value);
    }
    if (value.runtimeType == String) {
      prefs.setString(key, value);
    }
    if (value.runtimeType == bool) {
      prefs.setBool(key, value);
    }
  }

  Future<dynamic> get(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(key);
  }

  Future remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  Future<bool> hasKey(String key) async {
    var value = await get(key);
    return value != null;
  }
}
