import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_chef/Network/end_points.dart';
import 'package:food_chef/core/services/shared_pref_service.dart';
import 'package:food_chef/core/ui/auth/otp_login_screen.dart';
import 'package:get/get.dart';

import '../Network/api_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> checkProfile(String loginMode) async {
    Get.dialog(
      const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(
              "Please wait...",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    try {
      final response = await ApiService.to.postApi(
        url: EndPoints.check_profile,
        body: {
          "email": emailController.text.trim(),
          "loginMode": loginMode,
        },
        headerData: {
          "deviceId": SharedPrefService.deviceId,
          "deviceType": SharedPrefService.deviceType,
          "udid": SharedPrefService.udid,
          "sessionId": "234243534",
          "mmReqIdentifier": "asdacs933nc"
        },
      );

      Get.back();

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Check Profile");
        Navigator.pushReplacement(
            Get.context!,
            MaterialPageRoute(builder: (_) => OtpLoginScreen())
        );
      } else {
        Get.snackbar("Error", data['message'] ?? "Check Profile failed");
      }
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString());
    }
  }
}
