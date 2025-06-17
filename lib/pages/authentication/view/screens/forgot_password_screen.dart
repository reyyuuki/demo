import 'package:demo/pages/authentication/controller/auth_controller.dart';
import 'package:demo/pages/authentication/view/widgets/custom_button.dart';
import 'package:demo/pages/authentication/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
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

  Future<void> _sendResetEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        final success = await _authController.sendPasswordResetEmail(
          _emailController.text,
        );

        if (success) {
          Get.snackbar(
            'Success',
            'Password reset email sent. Check your inbox.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 4),
          );
          await Future.delayed(const Duration(milliseconds: 1000));
          Get.back();
        } else {
          Get.snackbar(
            'Error',
            _authController.errorMessage.isEmpty
                ? 'Failed to send reset email'
                : _authController.errorMessage,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 4),
          );
        }
      } catch (e) {
        Utils.log('Reset email error: $e');
        Get.snackbar(
          'Email Sent',
          'If an account with this email exists, you will receive a password reset link.',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reset password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter your email address and we\'ll send you a link to reset your password.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  required: true,
                ),
                const SizedBox(height: 32),
                Obx(
                  () => CustomButton(
                    text: 'Send reset email',
                    onPressed: _sendResetEmail,
                    isLoading: _authController.isLoading,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Remember your password? ',
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF0077B5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
