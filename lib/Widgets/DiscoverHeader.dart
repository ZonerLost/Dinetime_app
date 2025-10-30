import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DiscoverTab { people, hot, spotlight, likes }

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({
    super.key,
    required this.value,
    required this.onChanged,
    this.onFilterTap,
  });

  final DiscoverTab value;
  final ValueChanged<DiscoverTab> onChanged;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    // Colors tuned for a dark photo/background
    final Color textDim = Colors.white.withOpacity(0.85);
    final Color borderDim = Colors.white.withOpacity(0.18);

    TextStyle label(bool selected) => TextStyle(
      fontFamily: 'Helvetica-Bold', // swap if you don't have this font
      fontWeight: FontWeight.w700,
      fontSize: 12, // FittedBox below will scale down if needed
      height: 1.0,
      color: selected ? Colors.white : textDim,
      letterSpacing: 0.2,
    );

    Widget pillSelected(String text) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderDim, width: 0.8),
      ),
      child: Text(text, style: label(true)),
    );

    Widget labelButton(String text, DiscoverTab tab) => InkWell(
      onTap: () => onChanged(tab),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Text(text, style: label(false)),
      ),
    );

    final tabs = [
      value == DiscoverTab.people
          ? pillSelected('People')
          : labelButton('People', DiscoverTab.people),
      const SizedBox(width: 12),
      value == DiscoverTab.hot
          ? pillSelected('Hot & Trending')
          : labelButton('Hot & Trending', DiscoverTab.hot),
      const SizedBox(width: 12),
      value == DiscoverTab.spotlight
          ? pillSelected('Spotlight')
          : labelButton('Spotlight', DiscoverTab.spotlight),
      const SizedBox(width: 12),
      value == DiscoverTab.likes
          ? pillSelected('Likes')
          : labelButton('Likes', DiscoverTab.likes),
    ];

    return Row(
      children: [
        // Shrink-to-fit without horizontal scrolling (matches screenshot vibe)
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(mainAxisSize: MainAxisSize.min, children: tabs),
          ),
        ),
        const SizedBox(width: 8),
        // Small sliders icon on the right
        InkResponse(
          onTap: onFilterTap,
          radius: 18,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(
              CupertinoIcons.slider_horizontal_3,
              size: 18,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ],
    );
  }
}
