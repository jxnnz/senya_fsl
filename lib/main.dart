import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senya_fsl/themes/color.dart';
import 'screens/flashcard_screen.dart';
import 'screens/home_screen.dart';
import 'screens/logo_screen.dart';
import 'screens/practice_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import "screens/login_screen.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SENYA',
      theme: ThemeData(
        // You can define your app's overall theme here using AppColors
        primaryColor: AppColors.primaryColor,
        // You can add more theme configurations as needed
      ),
      initialRoute: '/',

      routes: {
        '/': (context) => const LogoScreen(), // Route for the welcome screen
        '/welcome':
            (context) => const WelcomeScreen(), // Another way to access welcome
        '/login':
            (context) => const LoginScreen(), // Route for the login screen
        '/signup':
            (context) => const SignupScreen(), // Route for the signup screen
        '/home': (context) => const HomeScreen(), // Route for the home screen
        '/flashcards':
            (context) => const FlashcardScreen(), // Route for flashcards
        '/practice': (context) => const PracticeScreen(), // Route for practice
        '/profile': (context) => const ProfileScreen(), // Route for profile
        //'/loading': (context) => const LoadingScreen(),
        // Route for loading
      }, // Set the LogoScreen as the starting screen
    );
  }
}
