part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginError extends AuthState {
  final String errorMessage;

  LoginError({this.errorMessage = 'Login failed. Please check your credentials.'});
}

final class ResgisterLoading extends AuthState {}

final class ResgisterSuccess extends AuthState {}

final class ResgisterError extends AuthState {
  final String errorMessage;

  ResgisterError({this.errorMessage = 'Registration failed. Please try again.'});
}

final class GoogleSignInLoading extends AuthState {}

final class GoogleSignInSuccess extends AuthState {}

final class GoogleSignInError extends AuthState {
  final String errorMessage;

  GoogleSignInError({this.errorMessage = 'Google Sign-In failed.'});
}


