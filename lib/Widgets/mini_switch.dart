import 'package:flutter/material.dart';

class MiniSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final double opacity;
  final Color activeColor;
  final Color inactiveColor;
  final Duration duration;
  final Curve curve;
  final String? semanticsLabel;

  const MiniSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 38,
    this.height = 21.375,
    this.opacity = 1.0,
    this.activeColor = Colors.black,
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.duration = const Duration(milliseconds: 160),
    this.curve = Curves.easeOut,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final double pad = height * 0.18; // ~3.8px for 21.375h
    final double knob = height - pad * 2;

    return Opacity(
      opacity: opacity,
      child: Semantics(
        label: semanticsLabel,
        toggled: value,
        button: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onChanged(!value),
          child: AnimatedContainer(
            duration: duration,
            curve: curve,
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: value ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: duration,
                  curve: curve,
                  left: value ? width - knob - pad : pad,
                  top: (height - knob) / 2,
                  child: Container(
                    width: knob,
                    height: knob,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
