import 'package:demo/pages/authentication/controller/auth_controller.dart';
import 'package:demo/pages/authentication/view/widgets/custom_button.dart';
import 'package:demo/pages/authentication/view/widgets/custom_text_field.dart';
import 'package:demo/pages/authentication/view/screens/forgot_password_screen.dart';
import 'package:demo/pages/authentication/view/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      final success = await _authController.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (success) {
        Get.offAllNamed('/home');
        Get.snackbar(
          'Success',
          'Sign in successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          _authController.errorMessage.isEmpty
              ? 'Sign in failed'
              : _authController.errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF0077B5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text(
              'LinkedIn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        label: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        required: true,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        label: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                        validator: _validatePassword,
                        required: true,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              Get.to(() => const ForgotPasswordScreen()),
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Color(0xFF0077B5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => CustomButton(
                          text: 'Sign in',
                          onPressed: _signIn,
                          isLoading: _authController.isLoading,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () => Get.off(() => const SignUpScreen()),
                            child: const Text(
                              'Join now',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0077B5),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
