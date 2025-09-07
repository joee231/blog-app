import 'package:blogapp/core/secrets/app_secrets.dart';
import 'package:blogapp/core/themes/theme.dart';
import 'package:blogapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blogapp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/presentation/pages/signup_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize
    (
      url: AppSecrets.supbaseUrl,
      anonKey: AppSecrets.supbaseApiKey
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthBloc(
          userSignUp: UserSignUp(
            authRepository: AuthRepositoryImpl(
              remoteDataSource:  authRemoteDataSourceImpl(
                supabaseClient: supabase.client
              ),
            ),
          ),
      ),
      ),
    ],
    child: const MyApp(),
      
  ));
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


