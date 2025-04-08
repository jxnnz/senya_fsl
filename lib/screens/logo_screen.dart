import 'package:flutter/material.dart';
import 'dart:async';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Apply the radial gradient
          gradient: RadialGradient(
            colors: [Color(0xFFF7B733), Color(0xFFFF7904)],
            center: Alignment.center,
            radius: 0.8,
            focal: Alignment.center,
            focalRadius: 0.2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/LOGO.png', // Replace with the actual path to your logo image
                width: 180, // Adjust the width of the logo
                height: 180, // Adjust the height of the logo
              ),
            ],
          ),
        ),
      ),
    );
  }
}
