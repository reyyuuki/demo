import 'package:demo/pages/authentication/controller/auth_controller.dart';
import 'package:demo/pages/authentication/view/widgets/custom_button.dart';
import 'package:demo/pages/authentication/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  int _currentStep = 0;
  bool _rememberMe = true;
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
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

  void _nextStep() {
    if (_currentStep == 0) {
      if (_firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty) {
        setState(() {
          _currentStep = 1;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else if (_currentStep == 1) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      final success = await _authController.signUpWithEmail(
        _emailController.text,
        _passwordController.text,
      );

      if (success) {
        Get.offAllNamed('/home');
      } else {
        Get.snackbar(
          'Error',
          _authController.errorMessage.isEmpty
              ? 'Sign up failed'
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: _currentStep == 0 ? 0.3 : 0.9,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF0077B5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _currentStep == 0 ? '30%' : '90%',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Create account',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [_buildNameStep(), _buildPasswordStep()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameStep() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight -
                120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Add your name',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'First name',
                controller: _firstNameController,
                required: true,
                validator: _validateName,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Last name',
                controller: _lastNameController,
                required: true,
                validator: _validateName,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              CustomButton(text: 'Continue', onPressed: _nextStep),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordStep() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight -
                  120,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Set your password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Email or Phone',
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
                const Text(
                  'Password must be 6+ characters',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      activeColor: const Color(0xFF0077B5),
                    ),
                    const Text('Remember me. '),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Learn more',
                        style: TextStyle(
                          color: Color(0xFF0077B5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Obx(
                  () => CustomButton(
                    text: 'Continue',
                    onPressed: _signUp,
                    isLoading: _authController.isLoading,
                  ),
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
