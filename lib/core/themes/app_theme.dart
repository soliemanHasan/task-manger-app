import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

/// This class [AppTheme] is defined to contain two basic variables that represent the application's theme,
///  where [darkTheme] represents the dark theme, [lightTheme] represents the basic theme.
///

class AppTheme {
  static AppTheme? _instance;
  AppTheme._();
  factory AppTheme() => _instance ??= AppTheme._();
  static const String _fontFamily = 'OpenSans';

  final lightTheme = ThemeData.light().copyWith(
    primaryColorLight: AppColors.primary,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 57.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontFamily: _fontFamily),
      displayMedium: TextStyle(
          fontSize: 45.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontFamily: _fontFamily),
      displaySmall: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontFamily: _fontFamily),
      headlineLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontFamily: _fontFamily),
      headlineMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontFamily: _fontFamily),
      headlineSmall: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          fontFamily: _fontFamily),

      ///
      labelLarge: TextStyle(
          fontSize: 14.sp, color: AppColors.black, fontFamily: _fontFamily), //
      labelMedium: TextStyle(
          fontSize: 12.sp, color: AppColors.white, fontFamily: _fontFamily),
      labelSmall: TextStyle(
          fontSize: 11.sp, color: AppColors.white, fontFamily: _fontFamily),
      titleLarge: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontFamily: _fontFamily),
      titleMedium: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          fontFamily: _fontFamily),
      titleSmall: TextStyle(
          fontSize: 14.sp, color: AppColors.primary, fontFamily: _fontFamily),
      bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontFamily: _fontFamily),
      bodyMedium: TextStyle(
          fontSize: 14.sp,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontFamily: _fontFamily), //
      bodySmall: TextStyle(
          fontSize: 12.sp, color: AppColors.white, fontFamily: _fontFamily),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.black),
      toolbarTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: AppColors.white,
    inputDecorationTheme: InputDecorationTheme(
      iconColor: AppColors.darkGrey,
      hintStyle: const TextStyle(
          color: AppColors.hintColor, fontFamily: _fontFamily, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: const BorderSide(color: AppColors.black),
      ),
      suffixIconColor: AppColors.black,
      prefixIconColor: AppColors.black,
      filled: true,
      fillColor: AppColors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: const BorderSide(color: AppColors.black, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: const BorderSide(color: AppColors.red, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: const BorderSide(color: AppColors.red, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
      ),
      labelStyle: const TextStyle(color: AppColors.green),
      errorStyle: const TextStyle(color: AppColors.red),
      counterStyle: const TextStyle(color: AppColors.black),
      isDense: true,
      helperStyle: const TextStyle(color: AppColors.black),
      suffixStyle: const TextStyle(color: AppColors.black),
      prefixStyle: const TextStyle(color: AppColors.black),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.green,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary.withOpacity(0.8),
      contentTextStyle: const TextStyle(color: AppColors.white),
      actionTextColor: AppColors.white,
    ),
  );
}
