import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<dynamic> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An unknown authentication error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An unknown authentication error occurred.';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}
    await _auth.signOut();
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  static Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User cancelled the sign-in flow
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _auth.signInWithCredential(credential);

      if (userCred.additionalUserInfo?.isNewUser ?? false) {
        // first time: e.g. save profile to Firestore
      }
      return userCred;
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase error: ${e.code}');
      return e.message ?? 'Firebase error: ${e.code}';
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return e.toString();
    }
  }
}
