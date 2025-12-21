import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: AppColor.WHITE,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // First Name
                  _buildInputField('First name', Icons.person),
                  const SizedBox(height: 16),

                  // Last Name
                  _buildInputField('Last name', Icons.person_outline),
                  const SizedBox(height: 16),

                  // Email
                  _buildInputField('Email', Icons.email),
                  const SizedBox(height: 16),

                  // Phone with country code
                  Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration( color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownMenu<String>(
                            initialSelection: '+91',
                            textStyle: const TextStyle(color: AppColor.WHITE),
                            menuStyle: MenuStyle( backgroundColor: MaterialStateProperty.all(AppColor.WHITE),),
                            inputDecorationTheme: const InputDecorationTheme(
                              border: InputBorder.none,
                            ),
                          onSelected: (value){

                          },
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(value: '+91', label: '+91'),
                              DropdownMenuEntry(value: '+1', label: '+1'),
                              DropdownMenuEntry(value: '+44', label: '+44'),
                              DropdownMenuEntry(value: '+61', label: '+61'),
                            ]
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
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: AppColor.WHITE),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.phone, color: AppColor.WHITE),
                              hintText: 'Phone number',
                              hintStyle: TextStyle(color: AppColor.WHITE),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Password
                  _buildInputField('Password', Icons.lock, obscure: true),
                  const SizedBox(height: 16),

                  // Confirm Password
                  _buildInputField('Confirm password', Icons.lock_outline, obscure: true),
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
                      onPressed: () {
                        // Handle registration logic
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 18, color: AppColor.WHITE),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: AppColor.WHITE),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to login screen
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: AppColor.btnBackground,
                            fontWeight: FontWeight.bold,
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

  Widget _buildInputField(String hint, IconData icon, {bool obscure = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        obscureText: obscure,
        style: const TextStyle(color: AppColor.WHITE),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColor.WHITE),
          hintText: hint,
          hintStyle: const TextStyle(color: AppColor.WHITE),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
