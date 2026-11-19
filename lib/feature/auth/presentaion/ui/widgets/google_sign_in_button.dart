import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_project/core/constants/app_colors.dart';
import 'package:firebase_project/core/widgets/google_icon.dart';
import 'package:firebase_project/feature/auth/presentaion/cubit/auth_cubit.dart';

class GoogleSignInButton extends StatelessWidget {
  final String text;
  final double height;
  final double borderRadius;

  const GoogleSignInButton({
    super.key,
    this.text = 'Continue with Google',
    this.height = 50,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is GoogleSignInLoading ||
          current is GoogleSignInSuccess ||
          current is GoogleSignInError ||
          current is AuthInitial,
      builder: (context, state) {
        final bool isLoading = state is GoogleSignInLoading;

        return SizedBox(
          width: double.infinity,
          height: height,
          child: OutlinedButton(
            onPressed: isLoading
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    context.read<AuthCubit>().signInWithGoogle();
                  },
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.surface,
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const GoogleIcon(size: 20),
                      const SizedBox(width: 12),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
