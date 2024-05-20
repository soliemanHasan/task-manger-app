import 'package:flutter/material.dart';
import 'package:task_manger_app/core/constants/app_colors.dart';

extension AppButtonTheme on ThemeData {
  // TODO: Customize app button decoration properties here

  BoxDecoration get appButtonTheme {
    return BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
