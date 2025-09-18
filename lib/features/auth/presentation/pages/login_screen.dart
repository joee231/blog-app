import 'package:blogapp/core/themes/app-palette.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/signup_screen.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/utils/show_snackbar.dart';

class LogInScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      );
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc , AuthState>(
          listener: ( context , state)
          {
            if(state is AuthFailure){
              return showSnackbar(context , state.message);
            } else if (state is AuthSuccess){
              Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false);
            }
          },
          builder: (context , state )
          {
            if (state is AuthLoading) {
              return Loader();
            }
            return  Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30.0),
                  AuthField(hintText: 'Email', controller: emailController),
                  SizedBox(height: 15.0),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isobscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  AuthGradientButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<AuthBloc>()
                            .add(
                            AuthLogIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim()
                            )
                        );
                      }
                    },
                    ButtonText: "Sign In",
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(context, SignupScreen.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
