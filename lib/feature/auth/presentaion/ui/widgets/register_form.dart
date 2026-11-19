import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_project/core/constants/app_colors.dart';
import 'package:firebase_project/core/utils/app_validators.dart';
import 'package:firebase_project/core/widgets/custom_elevated_button.dart';
import 'package:firebase_project/core/widgets/custom_password_field.dart';
import 'package:firebase_project/core/widgets/custom_text_field.dart';
import 'package:firebase_project/feature/auth/presentaion/cubit/auth_cubit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().register(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: _emailController,
            labelText: 'Email Address',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.validateEmail,
            prefixIcon: const Icon(
              Icons.mail_outline_rounded,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 18),
          CustomPasswordField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Create a password (min 6 characters)',
            textInputAction: TextInputAction.next,
            validator: AppValidators.validatePassword,
          ),
          const SizedBox(height: 18),
          CustomPasswordField(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            textInputAction: TextInputAction.done,
            validator: (value) => AppValidators.validateConfirmPassword(
              value,
              _passwordController.text,
            ),
            onFieldSubmitted: (_) => _onRegisterPressed(),
          ),
          const SizedBox(height: 24),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) =>
                current is ResgisterLoading ||
                current is ResgisterSuccess ||
                current is ResgisterError ||
                current is AuthInitial,
            builder: (context, state) {
              final bool isLoading = state is ResgisterLoading;
              return CustomElevatedButton(
                text: 'Create Account',
                isLoading: isLoading,
                onPressed: _onRegisterPressed,
              );
            },
          ),
        ],
      ),
    );
  }
}
