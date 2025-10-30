import 'package:canada/Constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextInputWidget extends StatelessWidget {
  // Core
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  // Layout
  final EdgeInsets? padding;

  // Icons
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // Borders
  final OutlineInputBorder border;                // required
  final OutlineInputBorder? focusedBorder;        // optional
  final OutlineInputBorder? errorBorder;          // optional
  final OutlineInputBorder? focusedErrorBorder;   // optional

  // Typography
  final String? inputFontFamily;
  final double? inputFontSize;
  final Color? inputFontColor;

  // Hints / behavior
  final String? hintText;
  final TextStyle? hintStyle;
  final bool obscureText;

  const CustomTextInputWidget({
    super.key,
    required this.controller,
    this.validator,
    required this.border,

    // Layout
    this.padding,

    // Icons
    this.prefixIcon,
    this.suffixIcon,

    // Borders
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,

    // Typography
    this.inputFontFamily,
    this.inputFontSize,
    this.inputFontColor,

    // Hints / behavior
    this.hintText,
    this.hintStyle = const TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 14,
      color: AppColors.gray200,
    ),
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: inputFontFamily ?? 'Helvetica',
      fontSize: inputFontSize ?? 14,
      color: inputFontColor ?? AppColors.black,
    );

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        style: textStyle,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
          filled: true,
          fillColor: const Color(0xFFE9E9EB),

          hintText: hintText,
          hintStyle: hintStyle,

          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

          // visible borders in all states
          border: border,
          enabledBorder: border,
          focusedBorder: focusedBorder ?? border,
          errorBorder: errorBorder ?? border,
          focusedErrorBorder: focusedErrorBorder ?? (errorBorder ?? border),

          // hide default error caption (you show custom row below)
          errorStyle: const TextStyle(fontSize: 0, height: 0),
          constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
        ),
      ),
    );
  }
}
