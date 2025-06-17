import 'package:demo/firebase_options.dart';
import 'package:demo/pages/authentication/controller/auth_controller.dart';
import 'package:demo/pages/authentication/view/screens/forgot_password_screen.dart';
import 'package:demo/pages/authentication/view/screens/home.dart';
import 'package:demo/pages/authentication/view/screens/signin_screen.dart';
import 'package:demo/pages/authentication/view/screens/signup_screen.dart';
import 'package:demo/pages/authentication/view/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      getPages: [
        GetPage(name: '/welcome', page: () => const WelcomeScreen()),
        GetPage(name: '/signin', page: () => const SignInScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
        GetPage(
          name: '/forgot-password',
          page: () => const ForgotPasswordScreen(),
        ),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
    );
  }
}
