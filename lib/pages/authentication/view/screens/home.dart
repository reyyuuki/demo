// ignore_for_file: deprecated_member_use

import 'package:demo/pages/authentication/controller/auth_controller.dart';
import 'package:demo/pages/feed/view/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.3),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.grey),
            onPressed: () => _showLogoutDialog(context, authController),
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFF0077B5),
                          backgroundImage: authController.user?.photoURL != null
                              ? NetworkImage(authController.user!.photoURL!)
                              : null,
                          child: authController.user?.photoURL == null
                              ? Text(
                                  authController.user?.displayName
                                          ?.substring(0, 1)
                                          .toUpperCase() ??
                                      authController.user?.email
                                          ?.substring(0, 1)
                                          .toUpperCase() ??
                                      'U',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                authController.user?.email?.split('@')[0] ??
                                    'User',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (authController.user?.email != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            authController.user!.email!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                    Row(
                      children: [
                        Icon(
                          authController.user?.isEmailVerified == true
                              ? Icons.verified_outlined
                              : Icons.warning_outlined,
                          size: 16,
                          color: authController.user?.isEmailVerified == true
                              ? Colors.green
                              : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          authController.user?.isEmailVerified == true
                              ? 'Email verified'
                              : 'Email not verified',
                          style: TextStyle(
                            fontSize: 14,
                            color: authController.user?.isEmailVerified == true
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      icon: Icons.person_add_outlined,
                      title: 'Connect',
                      subtitle: 'Find colleagues',
                      onTap: () {
                        Get.to(() => FeedScreen());
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionCard(
                      icon: Icons.work_outline,
                      title: 'Jobs',
                      subtitle: 'Find opportunities',
                      onTap: () {
                        Get.snackbar(
                          'Coming Soon',
                          'Jobs feature will be available soon!',
                          backgroundColor: const Color(0xFF0077B5),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      icon: Icons.message_outlined,
                      title: 'Messages',
                      subtitle: 'Start conversations',
                      onTap: () {
                        Get.snackbar(
                          'Coming Soon',
                          'Messages feature will be available soon!',
                          backgroundColor: const Color(0xFF0077B5),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionCard(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: 'Stay updated',
                      onTap: () {
                        Get.snackbar(
                          'Coming Soon',
                          'Notifications feature will be available soon!',
                          backgroundColor: const Color(0xFF0077B5),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: const Color(0xFF0077B5)),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    Get.dialog(
      AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Get.back();
              await authController.signOut();
              Get.offAllNamed('/welcome');
            },
            child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
