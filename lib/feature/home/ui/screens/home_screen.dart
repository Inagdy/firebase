import 'package:flutter/material.dart';
import 'package:firebase_project/core/constants/app_colors.dart';
import 'package:firebase_project/core/widgets/custom_elevated_button.dart';
import 'package:firebase_project/feature/auth/data/repo/auth.repo.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    await AuthRepo.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthRepo.getCurrentUser();
    final userEmail = user?.email ?? 'User';
    final displayName = user?.displayName;
    final photoUrl = user?.photoURL;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0.5,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            tooltip: 'Logout',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (photoUrl != null)
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(photoUrl),
                    backgroundColor: AppColors.primaryLight,
                  )
                else
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ),
                const SizedBox(height: 24),
                Text(
                  displayName != null ? 'Welcome, $displayName!' : 'Authentication Successful!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You are signed in as:',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    userEmail,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                CustomElevatedButton(
                  text: 'Sign Out',
                  icon: const Icon(Icons.logout_rounded, size: 20),
                  backgroundColor: AppColors.error,
                  onPressed: () => _handleLogout(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
