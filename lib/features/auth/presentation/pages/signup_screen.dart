import 'package:blogapp/core/themes/app-palette.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/auth_bloc.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      );
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc , AuthState>(
          listener: ( context , state)
          {
            if(state is AuthFailure){
              return showSnackbar(context , state.message);
            }
          },
          builder: (context , state )
          {
            if (state is AuthLoading) {
              return Loader();
            }

            return Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      AuthField(hintText: 'Name', controller: nameController),
                      SizedBox(height: 15.0),
                      AuthField(hintText: 'Email', controller: emailController),
                      SizedBox(height: 15.0),
                      AuthField(
                        hintText: 'Password',
                        controller: passwordController,
                        isobscureText: true,
                      ),
                      SizedBox(height: 20.0),
                      AuthGradientButton(
                        ButtonText: "Sign Up",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                AuthSIgnUp(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ));
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, LogInScreen.route());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: "Sign In",
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
