import 'dart:ui';
import 'package:canada/Widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class GlassChip extends StatelessWidget {
  final String text;
  final String? iconPath;
  final Color? backgroundColor;
  final double blur;
  final double borderOpacity;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Widget svg ;

  const GlassChip({
    super.key,
    required this.text,
    this.iconPath,
    this.backgroundColor,
    this.blur = 10,
    this.borderOpacity = 0.1,
    this.fontSize = 12,
    this.horizontalPadding = 10,
    this.verticalPadding = 8,
    required this.svg
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: (backgroundColor ?? const Color.fromARGB(77, 127, 127, 127)).withValues(alpha:  0.43),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: borderOpacity)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconPath != null) ...[
                svg,
                // svg(iconPath!, size: 16),
                const SizedBox(width: 6),
              ],
              CustomTextWidget(
               text:  text,
                
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}

