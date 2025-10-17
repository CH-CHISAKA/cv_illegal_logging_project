import 'package:cv_illegal_logging_project/views/auth/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Changed MyApp to IllegalLoggingApp for Prod
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Illegal Logging Detection',
      home: const SplashScreen(),

    );
  }
}