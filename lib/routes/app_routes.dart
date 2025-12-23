import 'package:flutter/material.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/walkthrough/walkthrough_screen.dart';

import '../core/ui/auth/otp_login_screen.dart';
import '../core/ui/splash/splash_screen.dart';

class AppRoutes {
  AppRoutes._();
  static const String splashScreen = '/splash_page';
  static const String walkthroughScreen = '/walkthrough_screen';
  static const String loginScreen = '/login_screen';
  static const String otpLoginScreen = '/otp_login_screen';



  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
        case splashScreen:
         return MaterialPageRoute(builder: (_) => const SplashScreen(isSeenWalkthrough: true,));

        case walkthroughScreen:
          return MaterialPageRoute(builder: (_) => const WalkthroughScreen());

        case loginScreen:
          return MaterialPageRoute(builder: (_) => const LoginScreen());

        case otpLoginScreen:
         return MaterialPageRoute(builder: (_) => const OtpLoginScreen());

      default:
                return MaterialPageRoute(
                    builder: (_) => const Scaffold(
                      body: Center(
                        child: Text('Route not found'),
                      ),
                    )
                );

    }

  }
}