import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/core/constants/app_colors.dart';
import 'package:firebase_project/feature/auth/presentaion/ui/screens/login_screen.dart';
import 'package:firebase_project/feature/home/ui/screens/home_screen.dart';
import 'package:firebase_project/firebase_options.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isUserLoggedIn = FirebaseAuth.instance.currentUser != null;

    return MaterialApp(
      title: 'Firebase Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
      ),
      home: isUserLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}

