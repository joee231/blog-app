import 'package:blogapp/core/themes/theme.dart';
import 'package:blogapp/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blog App",
      theme: AppTheme.darkThemeMode,
      home: const LogInScreen(),
    );
  }
}


