import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/utils/app_string.dart';
import 'package:google_fonts/google_fonts.dart';
import '../walkthrough/walkthrough_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Splash delay
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WalkthroughScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/splash.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Version ${AppString.appVersion}",
                      style: GoogleFonts.montserrat(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
  color: Colors.white),
),
                ),
              )  
            ],
          )
      ),
    );
  }
}
