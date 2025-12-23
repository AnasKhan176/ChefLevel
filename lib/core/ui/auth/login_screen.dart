import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_chef/core/ui/auth/register_screen.dart';
import 'package:food_chef/core/utils/app_string.dart';
import 'package:food_chef/core/utils/snackbar.dart';
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
                        GoogleFonts.playfairDisplay(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    AppString.enterYourLoginInformation,
                    style:
                        GoogleFonts.montserrat(
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
                        onPressed: () {},
                        child: Text(
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
                      onPressed: () {
                        if (!isEmail(_emailMobileController.text.toString().trim(),) &&
                            !isPhone(_emailMobileController.text.toString().trim(),)) {
                          CustomSnackBar.showTopSnackbar(
                            context,
                            'Please enter correct email or phone number',
                            AppColor.btnBackground,
                          );
                          setState(() {
                            _isProfileExist = false;
                          });
                        } else {
                          setState(() {
                            _isEmail = isEmail(
                              _emailMobileController.text.toString().trim(),
                            );
                            _isMobile = isPhone(
                              _emailMobileController.text.toString().trim(),
                            );
                          });

                          if (_isEmail == true &&
                              _emailMobileController.text
                                      .toString()
                                      .trim()
                                      .length <=
                                  255) {
                            // call check profile exist api and send email
                            CustomSnackBar.showTopSnackbar(
                              context,
                              'API mai email jaega.',
                              AppColor.btnBackground,
                            );
                            setState(() {
                              _isProfileExist = true;
                            });

                            if (_passwordController.text
                                    .toString()
                                    .isNotEmpty &&
                                _passwordController.text.toString().length <=
                                    8 &&
                                _isProfileExist == true) {
                              CustomSnackBar.showTopSnackbar(
                                context,
                                'login api with email.',
                                AppColor.btnBackground,
                              );
                              Navigator.pushNamed(context, '/otp_login_screen');
                            } else {
                              CustomSnackBar.showTopSnackbar(
                                context,
                                'Please enter password',
                                AppColor.btnBackground,
                              );
                            }

                            return;
                          } else if (_isMobile == true &&
                              _emailMobileController.text
                                      .toString()
                                      .trim()
                                      .length <=
                                  15) {
                            CustomSnackBar.showTopSnackbar(
                              context,
                              'API mai mobile jaega.',
                              AppColor.btnBackground,
                            );
                            setState(() {
                              _isProfileExist = true;
                            });

                            if (_passwordController.text
                                    .toString()
                                    .isNotEmpty &&
                                _passwordController.text.toString().length <=
                                    8 &&
                                _isProfileExist == true) {
                              CustomSnackBar.showTopSnackbar(
                                context,
                                'login api with mobile.',
                                AppColor.btnBackground,
                              );
                              Navigator.pushNamed(context, '/otp_login_screen');
                            } else {
                              CustomSnackBar.showTopSnackbar(
                                context,
                                'Please enter password',
                                AppColor.btnBackground,
                              );
                            }
                            return;
                          }

                          {
                            setState(() {
                              _isProfileExist = false;
                            });
                            CustomSnackBar.showTopSnackbar(
                              context,
                              _isEmail == true
                                  ? 'Please enter correct email'
                                  : 'Please enter correct phone number',
                              AppColor.btnBackground,
                            );
                            return;
                          }
                        }
                      },
                      child: Text(
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
                        style:
                            //  TextStyle(
                            //   color: AppColor.WHITE,
                            //   fontSize: 13,
                            // ),
                            GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.WHITE,
                            ),
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
                                  color: AppColor.btnBackground,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                               Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(builder: (_) => RegisterScreen())
                               );
                              }
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
