import 'package:shared_preferences/shared_preferences.dart';

class AuthJwt {
  static saveToken(key, data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  static Future<String> getToken(key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key) ?? null;
    return data;
  }

  static Future<void> removeToken(key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
