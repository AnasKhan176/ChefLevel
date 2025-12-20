import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_chef/theme/app_color.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  int _secondsRemaining = 23;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _controllers.map((controller) {
        return SizedBox(
          width: 40,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/common.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back, color: AppColor.WHITE),
                  SizedBox(height: 40),
                  Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColor.WHITE,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Check your mail, we've sent one time password verification code to +91 9876543210. Enter the code below to verify your account",
                    style: TextStyle(color: AppColor.WHITE),
                  ),
                  SizedBox(height: 32),
                  _buildOtpFields(),
                  SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.btnBackground,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      // Handle verification
                    },
                    child: Text('Verify'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '0:${_secondsRemaining.toString().padLeft(2, '0')}',
                    style: TextStyle(color: AppColor.WHITE),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: _secondsRemaining == 0
                        ? () {
                      setState(() {
                        _secondsRemaining = 30;
                        _startTimer();
                      });
                    }
                        : null,
                    child: Text(
                      "Don't get code? Resend It",
                      style: TextStyle(
                        color: _secondsRemaining == 0
                            ? AppColor.WHITE
                            : AppColor.WHITE,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
