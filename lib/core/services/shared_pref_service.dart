import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String walkthroughKey = 'is_walkthrough_seen';

  static Future<void> setWalkthroughSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(walkthroughKey, value);
  }

  static Future<bool> isWalkthroughSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(walkthroughKey) ?? false;
  }
}
