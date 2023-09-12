import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static String _key = 'sToken';

// Write DATA
  static Future<bool> saveUserData(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(_key, value);
  }

// Read Data
  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_key);
  }

  static Future deleteUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(_key);
  }
}
