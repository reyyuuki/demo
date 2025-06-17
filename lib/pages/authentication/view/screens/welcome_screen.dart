import 'package:demo/pages/authentication/controller/auth_controller.dart';
import 'package:demo/pages/authentication/view/widgets/custom_button.dart';
import 'package:demo/pages/authentication/view/screens/signin_screen.dart';
import 'package:demo/pages/authentication/view/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF0077B5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'LinkedIn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Join a trusted community of 1B professionals',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 3),
              Obx(
                () => Column(
                  children: [
                    CustomButton(
                      text: 'Continue with Google',
                      icon: Icons.g_mobiledata,
                      onPressed: () async {
                        final success = await authController.signInWithGoogle();
                        if (!success) {
                          Get.snackbar(
                            'Error',
                            authController.errorMessage.isEmpty
                                ? 'Google sign-in failed'
                                : authController.errorMessage,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          Get.offAllNamed('/home');
                          Get.snackbar(
                            'Success',
                            'Google sign-in successful',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      isLoading: authController.isLoading,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'Sign in with Email',
                      outlined: true,
                      onPressed: () => Get.to(() => const SignInScreen()),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'or',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'New to LinkedIn? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => const SignUpScreen()),
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
                    const SizedBox(height: 32),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        children: [
                          TextSpan(
                            text:
                                'By clicking Agree & Join or Continue, you agree to the LinkedIn ',
                          ),
                          TextSpan(
                            text: 'User Agreement',
                            style: TextStyle(color: Color(0xFF0077B5)),
                          ),
                          TextSpan(text: ', '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Color(0xFF0077B5)),
                          ),
                          TextSpan(text: ', and '),
                          TextSpan(
                            text: 'Cookie Policy',
                            style: TextStyle(color: Color(0xFF0077B5)),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
