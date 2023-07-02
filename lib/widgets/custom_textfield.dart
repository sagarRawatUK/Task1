import 'package:employeeapp/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// this file contains the ui part for [CustomTextField]
/// this widget is used to enter text in the textfield
/// and can be customized
///
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.fieldKey,
    this.hintText,
    this.validator,
    this.maxLines = 1,
    this.onChanged,
    this.initialValue,
    this.onSubmit,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor = ColorConstants.textfieldBorderColor,
    this.focusNode,
    this.textInputAction,
    this.textInputType,
    this.errorText,
    this.obscureText = false,
    this.isEnabled = true,
    this.textEditingController,
    this.maxLength,
    this.autofocus = false,
    this.onTap,
  });
  final Key? fieldKey;
  final FormFieldValidator? validator;
  final String? hintText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final String? initialValue;
  final double? borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? errorText;
  final bool obscureText;
  final bool isEnabled;
  final TextEditingController? textEditingController;
  final int? maxLength;
  final bool autofocus;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      enabled: isEnabled,
      maxLength: maxLength,
      obscureText: obscureText,
      focusNode: focusNode,
      autofocus: autofocus,
      validator: validator,
      cursorColor: Colors.black,
      initialValue: initialValue,
      onFieldSubmitted: onSubmit,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: textEditingController,
      style:
          Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        errorMaxLines: 2,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorConstants.textfieldHintColor,
            ),
        focusedErrorBorder: errorOutlineBorder(borderRadius ?? 7.sp),
        enabledBorder: outlineBorder(borderRadius ?? 7.sp, borderColor),
        disabledBorder: outlineBorder(borderRadius ?? 7.sp, borderColor),
        focusedBorder: outlineBorder(borderRadius ?? 7.sp, borderColor),
        errorBorder: errorOutlineBorder(borderRadius ?? 7.sp),
      ),
    );
  }
}

/// border style for textfield
///
OutlineInputBorder outlineBorder(double radius, Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
    ),
    borderRadius: BorderRadius.circular(radius),
  );
}

/// error border style for textfield
///
OutlineInputBorder errorOutlineBorder(double radius) {
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(radius),
  );
}
