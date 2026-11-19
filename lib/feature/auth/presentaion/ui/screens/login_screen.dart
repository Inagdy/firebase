import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_project/core/constants/app_colors.dart';
import 'package:firebase_project/core/widgets/app_snack_bar.dart';
import 'package:firebase_project/core/widgets/auth_header.dart';
import 'package:firebase_project/feature/auth/presentaion/cubit/auth_cubit.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/screens/register_screen.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/widgets/auth_navigation_prompt.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/widgets/google_sign_in_button.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/widgets/login_form.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/widgets/social_auth_divider.dart';
import 'package:firebase_project/feature/home/ui/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess || state is GoogleSignInSuccess) {
              AppSnackBar.showSuccess(
                context,
                message: state is GoogleSignInSuccess
                    ? 'Signed in with Google! Welcome back.'
                    : 'Signed in successfully! Welcome back.',
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            } else if (state is LoginError) {
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AuthHeader(
                      title: 'Welcome Back',
                      subtitle: 'Sign in to access your account',
                      icon: Icons.lock_open_rounded,
                    ),
                    const SizedBox(height: 32),
                    const LoginForm(),
                    const SizedBox(height: 20),
                    const SocialAuthDivider(),
                    const SizedBox(height: 20),
                    const GoogleSignInButton(text: 'Sign in with Google'),
                    const SizedBox(height: 24),
                    AuthNavigationPrompt(
                      promptText: "Don't have an account?",
                      actionText: 'Sign Up',
                      onActionPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
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
