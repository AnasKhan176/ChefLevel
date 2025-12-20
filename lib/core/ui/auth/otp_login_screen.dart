import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';

class OtpLoginScreen extends StatelessWidget {
  const OtpLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/common.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.85),
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Arrow
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: AppColor.WHITE,),
                  ),

                  const SizedBox(height: 24),

                  // Title
                  Text(
                    'Login',
                    style: TextStyle(
                      color: AppColor.WHITE,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Enter your login information',
                    style: TextStyle(
                      color: AppColor.WHITE,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Email / Phone Input
                  _inputField(),

                  const SizedBox(height: 24),

                  // Send OTP Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.btnBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Send OTP',
                        style: TextStyle(
                          color: AppColor.WHITE,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Register
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have any account? ",
                        style: TextStyle(
                          color: AppColor.WHITE,
                          fontSize: 14,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              color: AppColor.btnBackground,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      // style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: 'Email or phone number',
        // hintStyle: AppTextStyles.hint,
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: Colors.white70,
        ),
        filled: true,
        // fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
