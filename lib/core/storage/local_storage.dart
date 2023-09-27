import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static SharedPreferences? preferences;

  static Future<void> initial() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> addorUpdate(
      {required String key, required dynamic value}) async {
    return await preferences!.setString(key, value.toString());
  }

  static Future<bool> remove({required String key}) async {
    return await preferences!.remove(key);
  }

  static Future<String?> get({required String key}) async {
    return preferences!.getString(key);
  }
}

class StorageKeys {
  static const String userToken = "user_token";
  static const String isLogin = "is_login";
}
