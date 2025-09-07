import 'package:blogapp/core/secrets/app_secrets.dart';
import 'package:blogapp/core/themes/theme.dart';
import 'package:blogapp/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/presentation/pages/signup_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize
    (
      url: AppSecrets.supbaseUrl,
      anonKey: AppSecrets.supbaseApiKey
  );
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


