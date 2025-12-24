// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/user_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/domain/models/check_profile_model.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/utils/shared_pref_service.dart';
import 'package:food_chef/core/utils/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   
   
  final _firstNameontroller = TextEditingController();
  final _lastNameController = TextEditingController();
  
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool isEmail(String input) => EmailValidator.validate(input);
  bool isPhone(String input) =>
    RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
        .hasMatch(input);

  final userController = getIt.get<UserController>(); 


  Future<void>  _userRegistrationt() async
  {

    // Usage example:
final Map<String, dynamic> data = {
  'mobileNumber': _mobileController.text.toString(),
  'email': _emailController.text.toString(),
  'firstName': _firstNameontroller.text.toString(),
  'lastName': _lastNameController.text.toString(),
  'pin': _passwordController.text.toString(),
  'accountType': 'CUSTOMER',
};


DataModel api_response= await userController.createAccount(data);

if(api_response.responseCode == 20000)
{
CustomSnackBar.showTopSnackbar(context,api_response.message,AppColor.btnBackground);
// Redirect to login screen
Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen())
                          );
}else {

CustomSnackBar.showTopSnackbar(context,api_response.message,AppColor.btnBackground);

}

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/common.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
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
                    'Enter your personal data to create your account',
                    style:
                        GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 30),

                  // First Name
                  _nameInputField('First name', Icons.person, nameController:_firstNameontroller),
                  const SizedBox(height: 16),

                  // Last Name
                  _nameInputField('Last name', Icons.person_outline, nameController:_lastNameController),
                  const SizedBox(height: 16),

                  // Email
                  _emailInputField('Email', Icons.email, emailController: _emailController),
                  const SizedBox(height: 16),

                  // Phone with country code
                  Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownMenu<String>(
                          initialSelection: '+91',
                          textStyle:
                              // TextStyle(color: AppColor.WHITE),
                              GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.WHITE,
                              ),
                          menuStyle: MenuStyle(
                            backgroundColor: MaterialStateProperty.all(
                              AppColor.WHITE,
                            ),
                          ),
                          inputDecorationTheme: const InputDecorationTheme(
                            border: InputBorder.none,
                          ),
                          onSelected: (value) {},
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(value: '+91', label: '+91'),
                            DropdownMenuEntry(value: '+1', label: '+1'),
                            DropdownMenuEntry(value: '+44', label: '+44'),
                            DropdownMenuEntry(value: '+61', label: '+61'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: _mobileController,
                            keyboardType: TextInputType.phone,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.WHITE,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: AppColor.WHITE,
                              ),
                              hintText: 'Phone number',
                              hintStyle:
                                  //TextStyle(color: AppColor.WHITE),
                                  GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.WHITE,
                                  ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Password
                  _passwordInputField('Pin', Icons.lock, obscure: true, passwordController: _passwordController),
                  const SizedBox(height: 16),

                  // Confirm Password
                  _passwordInputField(
                    'Confirm pin',
                    Icons.lock_outline,
                    obscure: true, passwordController: _confirmController
                  ),
                  const SizedBox(height: 30),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.btnBackground,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        // Handle registration logic
                        if (_firstNameontroller.text.isNotEmpty && _lastNameController.text.isNotEmpty && _emailController.text.isNotEmpty 
                         && _mobileController.text.isNotEmpty && _passwordController.text.isNotEmpty && _confirmController.text.isNotEmpty
                        )
                        {
                          if (isEmail(_emailController.text.toString().trim()))
                          {
                            if (isPhone(_mobileController.text.toString().trim()))
                          {

                             if (_passwordController.text.toString().trim() == _confirmController.text.toString().trim() )
                          {
                            
                              await _userRegistrationt();
                          }else
                          {
                          CustomSnackBar.showTopSnackbar(context,'Pin & confirm pin should be same',AppColor.btnBackground);

                          }

                          }else
                          {
                          CustomSnackBar.showTopSnackbar(context,'Please enter correct mobile number',AppColor.btnBackground);

                          }

                          }else
                          {
                          CustomSnackBar.showTopSnackbar(context,'Please enter correct email id',AppColor.btnBackground);

                          }

                        }else{
                          CustomSnackBar.showTopSnackbar(context,'Please enter all fields',AppColor.btnBackground);
                        }
                      },
                      child: Text(
                        'Register',
                        style:
                            //TextStyle(fontSize: 18, color: AppColor.WHITE),
                            GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: AppColor.WHITE,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style:
                            GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.WHITE,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen())
                          );
                        },
                        child: Text(
                          'Login',
                          style:
                              // TextStyle(
                              //   color: AppColor.btnBackground,
                              //   fontWeight: FontWeight.bold,
                              // ),
                              GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.btnBackground,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // name 

  Widget _nameInputField(String hint, IconData icon, {required TextEditingController nameController} ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: nameController,
        style:
            GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.WHITE,
            ),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColor.WHITE),
          hintText: hint,
          hintStyle:
              GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.WHITE,
              ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _emailInputField(String hint, IconData icon,{required TextEditingController emailController}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: emailController,
        style:
            GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.WHITE,
            ),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColor.WHITE),
          hintText: hint,
          hintStyle:
              GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.WHITE,
              ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _passwordInputField(String hint, IconData icon, {bool obscure = false, required TextEditingController passwordController}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: passwordController,
        obscureText: obscure,
        maxLength: 6,
        keyboardType: TextInputType.number,
        style:
            GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.WHITE,
            ),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColor.WHITE),
          hintText: hint,
          hintStyle:
              GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.WHITE,
              ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }


}