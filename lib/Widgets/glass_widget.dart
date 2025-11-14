import 'dart:ui';
import 'package:flutter/material.dart';

class GlassWidget extends StatelessWidget {
  const GlassWidget({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Stack(
        children: [
          // 🟢 Glass blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(),
          ),

          // 🟢 Gradient + Border + Shadow
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
           
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),

              // 🔥 Glass background gradient
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha:  0.15),
                  Colors.white.withValues(alpha: 0.05),
                ],
              ),

              // 🔥 Glass border (light, premium)
              border: Border.all(
                width: 1.5,
                color: Colors.white.withValues(alpha: 0.25),
              ),

              // 🔥 Depth shadow
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
