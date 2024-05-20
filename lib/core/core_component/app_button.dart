import 'package:flutter/material.dart';
import 'package:task_manger_app/core/constants/app_colors.dart';
import 'package:task_manger_app/core/extensions/ui_extensions/app_button_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height,
    this.width,
    this.loading,
    this.margin,
  });

  final String label;
  final VoidCallback onTap;
  final EdgeInsets? margin;
  final bool? loading;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: margin,
        width: width,
        decoration: Theme.of(context).appButtonTheme,
        alignment: Alignment.center,
        child: loading == true
            ? const CircularProgressIndicator(
                color: AppColors.white,
              )
            : Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
      ),
    );
  }
}
