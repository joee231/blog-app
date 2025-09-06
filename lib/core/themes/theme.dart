import 'package:flutter/material.dart';

import 'app-palette.dart';

class AppTheme
{

  static  _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(
        color: color,
        width: 3.0

    ),
    borderRadius: BorderRadius.circular(10.0),
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppPallete.whiteColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27.0),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient1),
    ),

  );
}