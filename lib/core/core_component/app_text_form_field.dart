import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manger_app/core/constants/app_colors.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final Widget? icon;
  final bool isPass;

  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final BorderRadius? borderRadius;
  final Widget? prefixIcon;
  final EdgeInsets? padding;
  final bool readOnly;
  final void Function(String)? onChanged;

  const AppTextFormField({
    super.key,
    this.controller,
    this.hint,
    this.icon,
    this.keyboardType,
    this.isPass = false,
    this.validator,
    this.borderRadius,
    this.padding,
    this.prefixIcon,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _hide = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 320.w,
        height: 60.h,
        child: TextFormField(
          cursorColor: AppColors.primary,
          onChanged: widget.onChanged,
          style: const TextStyle(color: AppColors.black),
          readOnly: widget.readOnly,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          controller: widget.controller,
          validator: widget.validator,
          decoration: InputDecoration(
          
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.icon ??
                (widget.isPass
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _hide = !_hide;
                          });
                        },
                        icon: _hide
                            ? Icon(
                                Icons.visibility_off,
                                size: 18.sp,
                              )
                            : Icon(
                                Icons.visibility,
                                size: 18.sp,
                              ))
                    : null),
            isDense: true,
          ),
          obscureText: widget.isPass && _hide,
          keyboardType: widget.keyboardType,
        ),
      ),
    );
  }
}
