import 'package:flutter/material.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/providers/user_provider.dart';
import 'package:food_chef/core/ui/home/home_screen.dart';
import 'package:food_chef/core/ui/splash/splash_screen.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:food_chef/core/utils/function/utility.dart';
import 'package:provider/provider.dart';

import 'core/ui/home/tailored_recipes/receipe_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  final bool isSeenWalkthrough = await SharedPrefService.isWalkthroughSeen();
  final bool isLoggedIn = await SharedPrefService.isLoggedIn();

  final device = await Utility.getDeviceId(); //UDID
  final deviceType = await Utility.getDeviceType();
  if (device != null) {
    await SharedPrefService.setUDID(device);
  } else {
    await SharedPrefService.setUDID('UNKNOWN_DEVICE');
  }
  await SharedPrefService.setDeviceType(deviceType);
  // await SharedPrefService.setUDID('deviceuniqueid');
  // await SharedPrefService.setDeviceType('android');
  await SharedPrefService.setSessionID('sessionid');
  await SharedPrefService.setIdentifier('identifier');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(
        isSeenWalkthrough: isSeenWalkthrough,
        isLoggedIn: isLoggedIn,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isSeenWalkthrough;
  final bool isLoggedIn;
  const MyApp({
    super.key,
    required this.isSeenWalkthrough,
    required this.isLoggedIn,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: RecipeHomeScreen(),
      home: HomeScreen(),
      // home: SplashScreen(
      //   isSeenWalkthrough: isSeenWalkthrough,
      //   isLoggedIn: isLoggedIn,
      // ),
      // home: OtpVerificationScreen(contact: "23524278947", password: "password", loginMode: "loginMode", otpCode: "123456"),
    );
  }
}
