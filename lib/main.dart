
import 'constants_ui.dart';
import 'splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primaryColor),
        primaryColor: ColorConstants.primaryColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
