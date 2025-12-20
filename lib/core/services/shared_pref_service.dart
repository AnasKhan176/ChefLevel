import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final _prefs = SharedPreferences.getInstance();

  static Future<bool> isFirstLaunch() async {
    final prefs = await _prefs;
    return prefs.getBool('first_launch') ?? true;
  }

  static Future<void> setLaunched() async {
    final prefs = await _prefs;
    await prefs.setBool('first_launch', false);
  }
}
