import 'package:flutter/material.dart';
import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';

class InlineDropdown<T> extends StatefulWidget {
  final T? value;
  final List<T> options;
  final String placeholder;
  final String Function(T) labelOf;
  final ValueChanged<T> onChanged;
  final double fieldHeight;
  final double maxMenuHeight;

  const InlineDropdown({
    super.key,
    required this.value,
    required this.options,
    required this.placeholder,
    required this.labelOf,
    required this.onChanged,
    this.fieldHeight = 46,
    this.maxMenuHeight = 220,
  });

  @override
  State<InlineDropdown<T>> createState() => _InlineDropdownState<T>();
}

class _InlineDropdownState<T> extends State<InlineDropdown<T>>
    with SingleTickerProviderStateMixin {
  bool _open = false;

  void _toggle() => setState(() => _open = !_open);
  void _select(T v) {
    widget.onChanged(v);
    setState(() => _open = false);
  }

  @override
  Widget build(BuildContext context) {
    final String display = widget.value == null
        ? widget.placeholder
        : widget.labelOf(widget.value as T);

    final bool hasValue = widget.value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Field
        InkWell(
          onTap: _toggle,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            height: widget.fieldHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  display,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.0,
                    color: hasValue ? AppColors.text : const Color(0xFFB3B3B3),
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 160),
                  turns: _open ? 0.5 : 0.0,
                  child: Image.asset(
                    app_images.dropdown_arrow_png,
                    width: 16,
                    height: 16,
                    // remove color if your PNG is already black/colored
                    color: AppColors.black,             // tint if monochrome
                    filterQuality: FilterQuality.medium,
                  ),
                ),

              ],
            ),
          ),
        ),

        // Inline menu (opens beneath)
        AnimatedSize(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          child: _open
              ? Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
            ),
            constraints: BoxConstraints(maxHeight: widget.maxMenuHeight),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: widget.options.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFEDEDED)),
              itemBuilder: (_, i) {
                final opt = widget.options[i];
                final selected = widget.value == opt;
                return InkWell(
                  onTap: () => _select(opt),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.labelOf(opt),
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.0,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                        if (selected)
                          const Icon(Icons.check, size: 18, color: AppColors.black),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
