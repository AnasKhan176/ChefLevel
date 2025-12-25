import 'package:flutter/material.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/providers/login_provider.dart';
import 'package:food_chef/core/providers/preference_level_provider.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/auth/otp_verification_screen.dart';
import 'package:food_chef/core/ui/auth/register_screen.dart';
import 'package:food_chef/core/ui/home/home.dart';
import 'package:food_chef/core/ui/preference/preference_screen.dart';
import 'package:food_chef/core/ui/splash/splash_screen.dart';
import 'package:food_chef/core/utils/shared_pref_service.dart';
import 'package:food_chef/core/utils/utility.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  final bool isSeenWalkthrough = await SharedPrefService.isWalkthroughSeen();
  final device = await Utility.getDeviceId();//UDID
  final deviceType = await Utility.getDeviceType();
  if(device != null) {
    await SharedPrefService.setUDID(device);
  }else {
    await SharedPrefService.setUDID('UNKNOWN_DEVICE');
  }
  await SharedPrefService.setDeviceType(deviceType);
  // await SharedPrefService.setUDID('shdfrtgklj');
  // await SharedPrefService.setDeviceType('android');
  await SharedPrefService.setSessionID('sdfad99fdshu');
  await SharedPrefService.setIdentifier('asdacs933nck');

  runApp(
    MultiProvider(
      providers:[

        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => PreferenceLevelProvider()),

    ], child: MyApp(isSeenWalkthrough: isSeenWalkthrough))
    
    
    );
}
class MyApp extends StatelessWidget {
  final bool isSeenWalkthrough;
  const MyApp({super.key, required this.isSeenWalkthrough});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(isSeenWalkthrough: isSeenWalkthrough),
      // home: OtpVerificationScreen(contact: "23524278947", password: "password", loginMode: "loginMode", otpCode: "123456"),
    );
  }
}

