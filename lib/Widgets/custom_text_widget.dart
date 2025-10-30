import 'package:flutter/material.dart';
import '../Constants/app_colors.dart';

/// Font aliases (ensure you've registered these in pubspec.yaml)
const String kFontFamily = 'Helvetica';
const String kBoldFont = 'Helvetica-Bold';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontFamily,
    this.textAlign,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: fontFamily ?? kFontFamily,
        color: color ?? AppColors.text, 
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: height,
      ),
    );
  }
}

/// Headings: explicitly uses the bold TTF (Helvetica-Bold)
Widget headingText(
    String text, {
      double size = 26,
      Color color = AppColors.black,
      TextAlign align = TextAlign.start,
    }) {
  return CustomTextWidget(
    text: text,
    fontFamily: kBoldFont,
    fontWeight: FontWeight.w700,
    fontSize: size,
    color: color,
    textAlign: align,
  );
}

/// Regular body text
Widget bodyText(
    String text, {
      double size = 13,
      Color color = AppColors.text,
      FontWeight weight = FontWeight.w400,
      TextAlign align = TextAlign.start,
      double? height,
      TextOverflow? overflow,
      int? maxLines,
    }) {
  return CustomTextWidget(
    text: text,
    fontFamily: kFontFamily,
    fontSize: size,
    color: color,
    fontWeight: weight,
    textAlign: align,
    height: height,
    overflow: overflow,
    maxLines: maxLines,
  );
}

/// Form label with a little bottom padding
Widget formLabel(
    String text, {
      double size = 14,
      Color color = AppColors.black,
      FontWeight weight = FontWeight.w400,
    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: bodyText(text, size: size, color: color, weight: weight),
  );
}

/// Input decoration with configurable fill and borders.
/// Matches your app’s visual language (grey fill + visible borders).
InputDecoration fieldDecoration(
    String hint, {
      double radius = 10,
      Color fill = const Color(0xFFF0F0F0),
      EdgeInsets content = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

      // Borders/colors
      Color borderColor = AppColors.greyshade3,
      Color focusedColor = AppColors.black,
      Color errorColor = const Color(0xFFD32F2F),

      // Optional icons & styles
      Widget? prefixIcon,
      Widget? suffixIcon,
      TextStyle? hintStyle,
      TextStyle errorStyle = const TextStyle(fontSize: 0, height: 0), // hide caption
    }) {
  OutlineInputBorder _outlined(Color c) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(color: c, width: 1),
  );

  return InputDecoration(
    hintText: hint,
    hintStyle: hintStyle ??
        const TextStyle(
          fontFamily: kFontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.gray200,
        ),
    isDense: true,
    contentPadding: content,
    filled: true,
    fillColor: fill,

    // Icons (null-safe)
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,

    // Visible borders in all states
    border: _outlined(borderColor),
    enabledBorder: _outlined(borderColor),
    focusedBorder: _outlined(focusedColor),
    errorBorder: _outlined(errorColor),
    focusedErrorBorder: _outlined(errorColor),

    // Hide default error text (you render your own below the field)
    errorStyle: errorStyle,
  );
}
