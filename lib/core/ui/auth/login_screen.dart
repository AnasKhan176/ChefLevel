// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/controller/user_controller.dart';
import 'package:food_chef/core/domain/models/check_profile_model.dart';
import 'package:food_chef/core/ui/auth/otp_verification_screen.dart';
import 'package:food_chef/core/ui/auth/register_screen.dart';
import 'package:food_chef/core/ui/home/home.dart';
import 'package:food_chef/core/ui/preference/preference_screen.dart';
import 'package:food_chef/core/ui/snackbar/app_loader.dart';
import 'package:food_chef/core/ui/snackbar/bottom_snackbar.dart';
import 'package:food_chef/core/utils/app_string.dart';
import 'package:food_chef/core/utils/shared_pref_service.dart';
import 'package:food_chef/theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _isEmail = false;
  bool _isMobile = false;
  bool _isProfileExist = false;
  final _emailMobileController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isEmail(String input) => EmailValidator.validate(input);
  bool isPhone(String input) => RegExp(
    r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
  ).hasMatch(input);

  final userController = getIt.get<UserController>();

  Future<void> _checkProfileExist(bool email, bool phone) async {
    // Usage example:
    final Map<String, dynamic> data = {
      email == true ? 'email' : 'mobileNumber': _emailMobileController.text
          .toString()
          .trim(),
      'loginMode': email == true ? 'email' : 'mobile',
    };

    DataModel api_response = await userController.checkUserProfileExist(data);
    print(api_response.responseCode);
    print(api_response.message);

    if (api_response.responseCode == 20000) {
      setState(() {
        _isProfileExist = false;
      });
      BottomSnackBar.show(
        context,
        message: 'Please register your account.!!',
        backgroundColor: AppColor.btnBackground,
        icon: Icons.error,
      );
      // User not exist, please open registration screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => RegisterScreen()),
      );
    } else if (api_response.responseCode == 5120) {
      setState(() {
        _isProfileExist = true;
      });
      await SharedPrefService.setUid(api_response.data?.uid);

      if (_isProfileExist) {
        if (_passwordController.text.isNotEmpty &&
            _emailMobileController.text.isNotEmpty) {
          _checkLogin(email, phone);
        } else {
          BottomSnackBar.show(
            context,
            message: api_response.message!,
            backgroundColor: AppColor.btnBackground,
            icon: Icons.check_circle,
          );
        }
      }
    } else {
      BottomSnackBar.show(
        context,
        message: api_response.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
  }

  Future<void> _checkLogin(bool email, bool phone) async {
    // Usage example:
    final Map<String, dynamic> data = {
      'loginId': _emailMobileController.text.toString().trim(),
      'loginMode': email == true ? 'email' : 'mobile',
      'password': _passwordController.text.toString().trim(),
    };

    DataModel api_response = await userController.login(data);
    print(api_response.responseCode);
    print(api_response.message);

    AppLoader.show(context);

    if (api_response.responseCode == 20000) {
      AppLoader.hide();
      setState(() {
        _isProfileExist = false;
      });
      final bool isPrefLevel = await SharedPrefService.isPrefLevel();
      await SharedPrefService.setLoggedIn(true);
      await SharedPrefService.setUserId(_emailMobileController.text.toString().trim());
      await SharedPrefService.setPin(_passwordController.text.toString().trim());

      BottomSnackBar.show(
        context,
        message: api_response.message!,
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
      if (isPrefLevel) {
        //Home Screen open hogi
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        AppLoader.hide();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => PreferencesScreen()),
        );
      }
    } else if (api_response.responseCode == 20019) {
      AppLoader.hide();
      setState(() {
        _isProfileExist = false;
      });
      // open OTP screen & pass the data
      //{"status":"SUCCESS","message":"SUCCESS","responseCode":20019,"data":{"check":"019931","uid":null}}
      
      await SharedPrefService.setUserId(_emailMobileController.text.toString().trim());
      await SharedPrefService.setPin(_passwordController.text.toString().trim());
      BottomSnackBar.show(
        context,
        message: 'Otp Sent : ${api_response.data!.check}',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            contact: _emailMobileController.text.toString(),
            password: _passwordController.text.toString(),
            loginMode: email == true ? 'email' : 'mobile',
            otpCode: api_response.data?.check,
          ),
        ),
      );
    } else {
      AppLoader.hide();

      BottomSnackBar.show(
        context,
        message: api_response.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
  }

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
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    AppString.enterYourLoginInformation,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Email / Phone
                  _buildInputField(
                    hint: AppString.emailPhone,
                    icon: Icons.email_outlined,
                    textController: _emailMobileController,
                  ),

                  const SizedBox(height: 16),

                  // Password
                  Visibility(
                    visible: _isProfileExist,
                    child: _buildInputField(
                      hint: AppString.password,
                      icon: Icons.lock_outline,
                      isPassword: true,
                      textController: _passwordController,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Forgot Password
                  Visibility(
                    visible: _isProfileExist,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          BottomSnackBar.show(
                            context,
                            message: AppString.forgotPassword,
                            backgroundColor: Colors.green,
                            icon: Icons.check_circle,
                          );
                        },
                        child: Text(
                          AppString.forgotPassword,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: AppColor.btnBackground,
                          ),
                        ),
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
                      onPressed: () async {
                        if (!isEmail(
                              _emailMobileController.text.toString().trim(),
                            ) &&
                            !isPhone(
                              _emailMobileController.text.toString().trim(),
                            )) {
                          BottomSnackBar.show(
                            context,
                            message:
                                'Please enter correct email or phone number.!!',
                            backgroundColor: AppColor.btnBackground,
                            icon: Icons.error,
                          );
                        } else {
                          _checkProfileExist(
                            isEmail(
                              _emailMobileController.text.toString().trim(),
                            ),
                            isPhone(
                              _emailMobileController.text.toString().trim(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        AppString.login,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),
                  // Register Text
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: AppString.dontAccount,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.WHITE,
                        ),
                        children: [
                          TextSpan(
                            text: AppString.register,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.btnBackground,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RegisterScreen(),
                                  ),
                                );
                              },
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
    required TextEditingController textController,
  }) {
    return TextField(
      controller: textController,
      obscureText: isPassword ? _obscurePassword : false,
      maxLength: isPassword ? 8 : 255,
      keyboardType: isPassword ? TextInputType.number : TextInputType.text,
      inputFormatters: isPassword
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ]
          : <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'.*')),
            ],
      style:
          // TextStyle(color: Colors.white),
          GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
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
