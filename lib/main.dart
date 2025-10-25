import 'package:cv_illegal_logging_project/views/auth/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Auth service instance
// final authService = AuthService();

void main() async {
  // Supabase setup 
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bgkvbkxjxksivbnoduzi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJna3Zia3hqeGtzaXZibm9kdXppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEyODQ4OTIsImV4cCI6MjA3Njg2MDg5Mn0.C5bc18RHSIWvPkDioSBdnWX6wI_pvF1xfd6Y281h_ek'
  );

  // Try to restore session if "remember me" was set
  // await authService.restoreSessionIfNeeded();


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