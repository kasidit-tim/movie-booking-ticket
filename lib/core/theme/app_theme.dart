import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData dark = ThemeData(
    fontFamily: 'SF Pro Display',
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.background,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
      ),
    ),
  );
}
