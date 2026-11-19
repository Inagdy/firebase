import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_project/core/constants/app_colors.dart';
import 'package:firebase_project/core/widgets/app_snack_bar.dart';
import 'package:firebase_project/core/widgets/auth_header.dart';
import 'package:firebase_project/feature/auth/presentaion/cubit/auth_cubit.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/widgets/auth_navigation_prompt.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/widgets/google_sign_in_button.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/widgets/register_form.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/widgets/social_auth_divider.dart';
import 'package:firebase_project/feature/home/ui/screens/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ResgisterSuccess || state is GoogleSignInSuccess) {
              AppSnackBar.showSuccess(
                context,
                message: state is GoogleSignInSuccess
                    ? 'Signed in with Google! Welcome.'
                    : 'Account created successfully! Welcome aboard.',
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            } else if (state is ResgisterError) {
              AppSnackBar.showError(
                context,
                message: state.errorMessage,
              );
            } else if (state is GoogleSignInError) {
              AppSnackBar.showError(
                context,
                message: state.errorMessage,
              );
            }
          },
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AuthHeader(
                      title: 'Create Account',
                      subtitle: 'Sign up to get started with your account',
                      icon: Icons.person_add_alt_1_rounded,
                    ),
                    const SizedBox(height: 28),
                    const RegisterForm(),
                    const SizedBox(height: 20),
                    const SocialAuthDivider(),
                    const SizedBox(height: 20),
                    const GoogleSignInButton(text: 'Sign up with Google'),
                    const SizedBox(height: 24),
                    AuthNavigationPrompt(
                      promptText: 'Already have an account?',
                      actionText: 'Log In',
                      onActionPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
