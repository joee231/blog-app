import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/app-palette.dart';

class AuthGradientButton extends StatelessWidget {
  final String ButtonText;
  final VoidCallback? onPressed;
  const AuthGradientButton({
    super.key,
    required  this.ButtonText ,
    required  this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child:  Text(
          ButtonText,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        ),
      ),
    );
  }
}
