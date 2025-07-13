import 'dart:async';
import 'package:calory/src/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () =>
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const WelcomeScreen())));
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset("assets/logo/Group 83.png",height: 100,width: 100),
          ),
        ],
      ),
    );
  }
}
