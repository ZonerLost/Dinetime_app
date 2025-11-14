import 'package:canada/Constants/responsive.dart';
import 'package:canada/Widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Widget? image; // 👈 dynamic image widget
  final VoidCallback? onTap;
  final double height;
  final double borderRadius;
  final Color color;
  final Color textColor;
  final bool? isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.image,                 // 👈 allow passing image
    this.onTap,
    this.height = 50,
    this.borderRadius = 8,
    this.color = Colors.black,
    this.textColor = Colors.white,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading == true ? null : onTap,
      child: Container(
        width: context.screenWidth,
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: isLoading == true ? Colors.grey : color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: isLoading == true
            ? const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (image != null) ...[
                    image!,                
                    const SizedBox(width: 8),
                  ],
                  CustomTextWidget(
                    text: text,
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ],
              ),
      ),
    );
  }
}
