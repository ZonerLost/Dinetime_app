import 'package:canada/Constants/app_colors.dart';
import 'package:canada/Constants/app_images.dart';
import 'package:flutter/material.dart';

class FilterPill extends StatelessWidget {
  const FilterPill({super.key, required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha:  0.70), 
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(app_images.dropdown_arrow_png, color: AppColors.background, width: 22, height: 22),
          ],
        ),
      ),
    );
  }
}