import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String walkthroughKey = 'is_walkthrough_seen';
  static const String deviceType = "device_type";
  static const String udid = "udid";
  static const String deviceId = "device_id";

  static Future<void> setWalkthroughSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(walkthroughKey, value);
  }

  static Future<bool> isWalkthroughSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(walkthroughKey) ?? false;
  }

  static Future<void> setUDID(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(udid, value);
  }

  static Future<String> getUDID() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(udid) ?? "";
  }

  static Future<void> setDeviceType(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(deviceType, value);
  }

  static Future<String> getDeviceType() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(deviceType) ?? "";
  }

  static Future<void> setDeviceId(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(deviceId, value);
  }

  static Future<String> getDeviceId() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(deviceId) ?? "";
  }
}
