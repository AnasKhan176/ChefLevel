import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';

class Utility {
  static Future<String?> getDeviceUdid() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
  }

    static Future<String> getDeviceType() async{
      if (Platform.isAndroid) {
        return "Android";
      } else if (Platform.isIOS) {
        return "iOS";
      } else if (Platform.isWindows) {
        return "Windows";
      } else if (Platform.isMacOS) {
        return "macOS";
      } else if (Platform.isLinux) {
        return "Linux";
      } else if (Platform.isFuchsia) {
        return "Fuchsia";
      } else {
        return "Unknown";
      }
    }

  static Future<String?> getDeviceId() async {
    try {
      String? deviceId = await MobileDeviceIdentifier().getDeviceId(); print("Device ID: $deviceId");
    } catch (e) {
      print("Error fetching device ID: $e");
    }
  }

}