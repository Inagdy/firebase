import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_project/core/constants/app_colors.dart';
import 'package:firebase_project/core/utils/app_validators.dart';
import 'package:firebase_project/core/widgets/custom_elevated_button.dart';
import 'package:firebase_project/core/widgets/custom_password_field.dart';
import 'package:firebase_project/core/widgets/custom_text_field.dart';
import 'package:firebase_project/feature/auth/presentaion/cubit/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
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
            hintText: 'Enter your password',
            textInputAction: TextInputAction.done,
            validator: AppValidators.validatePassword,
            onFieldSubmitted: (_) => _onLoginPressed(),
          ),
          const SizedBox(height: 24),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) =>
                current is LoginLoading ||
                current is LoginSuccess ||
                current is LoginError ||
                current is AuthInitial,
            builder: (context, state) {
              final bool isLoading = state is LoginLoading;
              return CustomElevatedButton(
                text: 'Log In',
                isLoading: isLoading,
                onPressed: _onLoginPressed,
              );
            },
          ),
        ],
      ),
    );
  }
}
