import 'package:flutter/material.dart';
import 'package:task_manger_app/core/constants/app_colors.dart';
import 'package:task_manger_app/core/constants/app_shadow.dart';

extension CategoryComponentTheme on ThemeData {
  BoxDecoration get categoryDecoration {
    return BoxDecoration(
      color: AppColors.white,
      border: Border.all(width: 1, color: AppColors.darkGrey),
      boxShadow: [AppShadows.normalShadow],
      borderRadius: BorderRadius.circular(10),
    );
  }
}
