import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/feature/auth/data/repo/auth.repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> register({required String email, required String password}) async {
    emit(ResgisterLoading());
    final response = await AuthRepo.register(email: email, password: password);

    if (response is UserCredential) {
      emit(ResgisterSuccess());
    } else {
      emit(ResgisterError(
        errorMessage: response is String ? response : 'Registration failed.',
      ));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final response = await AuthRepo.login(email: email, password: password);

    if (response is UserCredential) {
      emit(LoginSuccess());
    } else {
      emit(LoginError(
        errorMessage: response is String ? response : 'Login failed.',
      ));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());
    final response = await AuthRepo.signInWithGoogle();

    if (response is UserCredential) {
      emit(GoogleSignInSuccess());
    } else if (response != null) {
      emit(GoogleSignInError(
        errorMessage: response is String ? response : 'Google Sign-In failed.',
      ));
    } else {
      emit(AuthInitial());
    }
  }
}


