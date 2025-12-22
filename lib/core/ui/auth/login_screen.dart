import 'package:flutter/material.dart';
import 'package:food_chef/core/utils/app_string.dart';
import 'package:food_chef/theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

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
                colors: [
                  Colors.black.withOpacity(0.85),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.85),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: AppColor.WHITE),
                  ),

                  const SizedBox(height: 20),

                  // Title
                   Text(
                    AppString.login,
                    style: 
                    // TextStyle(
                    //   color: AppColor.WHITE,
                    //   fontSize: 30,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    GoogleFonts.playfairDisplay(
  fontSize: 30,
  fontWeight: FontWeight.w600,
  fontStyle: FontStyle.normal,
  color: Colors.white),
                  ),

                  const SizedBox(height: 8),

                   Text(
                    AppString.enterYourLoginInformation,
                    style: 
                    // TextStyle(
                    //   color: AppColor.WHITE,
                    //   fontSize: 14,
                    // ),
                    GoogleFonts.montserrat(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  color: Colors.white),
                  ),

                  const SizedBox(height: 30),

                  // Email / Phone
                  _buildInputField(
                    hint: AppString.emailPhone,
                    icon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 16),

                  // Password
                  _buildInputField(
                    hint: AppString.password,
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),

                  const SizedBox(height: 12),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child:  Text(
                        AppString.forgotPassword,
                        style: 
                        // TextStyle(
                        //   color: AppColor.btnBackground,
                        //   fontSize: 13,
                        // ),
                         GoogleFonts.montserrat(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  color: AppColor.btnBackground),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Login Button
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/otp_login_screen');
                      },
                      child:  Text(
                        AppString.login,
                        style: 
                        // TextStyle(
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.bold,
                        //   color: AppColor.WHITE
                        // ),
                         GoogleFonts.montserrat(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.normal,
  color: Colors.white),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Register Text
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: AppString.dontAccount,
                        style: 
                        //  TextStyle(
                        //   color: AppColor.WHITE,
                        //   fontSize: 13,
                        // ),
                         GoogleFonts.montserrat(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: AppColor.WHITE),
                        children: [
                          TextSpan(
                            text: AppString.register,
                            style: 
                            //  TextStyle(
                            //   color: AppColor.btnBackground,
                            //   fontWeight: FontWeight.bold,
                            // ),
                             GoogleFonts.montserrat(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: AppColor.btnBackground),
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

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword ? _obscurePassword : false,
      style: 
      // TextStyle(color: Colors.white),
       GoogleFonts.montserrat(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        )
            : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
