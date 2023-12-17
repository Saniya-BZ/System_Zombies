import 'dart:async';

// import 'package:eco_feast/constants.dart';
// import 'package:eco_feast/screens/onboarding_screen.dart';
import 'onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'constants_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              ImageConstants.logo,
              width: 200,
              height: 200,
            ),
            const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: ColorConstants.primaryColor,
                ))
          ])),
    );
  }
}
