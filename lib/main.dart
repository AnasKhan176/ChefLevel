import 'package:flutter/material.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/auth/register_screen.dart';
import 'package:food_chef/core/ui/preference/preference_screen.dart';
import 'package:food_chef/core/ui/walkthrough/walkthrough_screen.dart';
import 'package:food_chef/core/utils/utility.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Network/api_service.dart';
import 'core/services/shared_pref_service.dart';
import 'core/ui/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isSeenWalkthrough = await SharedPrefService.isWalkthroughSeen();
  final device = await Utility.getDeviceId();//UDID
  final deviceType = await Utility.getDeviceType(); // DEVCE TYPE
  await SharedPrefService.setUDID(device!);
  await SharedPrefService.setDeviceType(deviceType);
  Get.put(ApiService());
  runApp(MyApp(isSeenWalkthrough: isSeenWalkthrough,));
}

class MyApp extends StatelessWidget {
  final bool isSeenWalkthrough;
  const MyApp({super.key, required this.isSeenWalkthrough});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(isSeenWalkthrough: isSeenWalkthrough),
    );
  }
}

