import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/app_colors.dart';
import '../Widgets/custom_text_widget.dart';
import '../view_model/hungry_active_view_model.dart';

class FilterSheet extends StatelessWidget {
  final HungryActiveVM vm;
  const FilterSheet({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    // Spec from mock
    const double targetWidth  = 414;
    const double targetHeight = 394;

    // keep within screen width; center horizontally
    final double sheetWidth = w < targetWidth ? w : targetWidth;
    final double side = (w - sheetWidth) / 2;

    return SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          // small bottom gap like the mock
          padding: EdgeInsets.fromLTRB(side, 0, side, 16),
          child: SizedBox(
            width: sheetWidth,
            height: targetHeight,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                color: Color(0xF5111111), // ~0.96 opacity dark
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Obx(() {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 129, height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Title centered with close on the right (title stays centered)
                    SizedBox(
                      height: 40,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: headingText('Filter', size: 26, color: Colors.white, /* weight: FontWeight.w700 */),
                          ),
                          Positioned(
                            right: -8, // slight optical tweak to match mock
                            child: IconButton(
                              onPressed: Get.back,
                              splashRadius: 18,
                              icon: const Icon(Icons.close, color: Colors.white, size: 26),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Subtitle
                    const SizedBox(height: 6),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320),
                        child: bodyText(
                          'Adjust your discovery preferences.',
                          size: 14,
                          color: Colors.white.withOpacity(0.80),
                          // textAlign is inside your bodyText; if not, wrap with Text and set textAlign: TextAlign.center
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Gender section
                    headingText('Gender', size: 18, color: Colors.white /*, weight: FontWeight.w700 */),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _radioChip(
                          label: 'Any',
                          value: HgGender.any,
                          group: vm.filterGender.value,
                          onTap: () => vm.filterGender.value = HgGender.any,
                        ),
                        _radioChip(
                          label: 'Male',
                          value: HgGender.male,
                          group: vm.filterGender.value,
                          onTap: () => vm.filterGender.value = HgGender.male,
                        ),
                        _radioChip(
                          label: 'Female',
                          value: HgGender.female,
                          group: vm.filterGender.value,
                          onTap: () => vm.filterGender.value = HgGender.female,
                        ),
                        _radioChip(
                          label: 'Other',
                          value: HgGender.other,
                          group: vm.filterGender.value,
                          onTap: () => vm.filterGender.value = HgGender.other,
                        ),
                      ],
                    ),

                    const SizedBox(height: 29),

                    // Distance section
                    headingText('Distance', size: 15, color: Colors.white /*, weight: FontWeight.w700 */),
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2.5,
                        inactiveTrackColor: Colors.white24,
                        activeTrackColor: Colors.white,
                        thumbColor: Colors.white,
                        overlayColor: Colors.white24,
                        valueIndicatorColor: Colors.white,
                      ),
                      child: Slider(
                        min: 1,
                        max: 50,
                        divisions: 49,
                        value: vm.filterMiles.value,
                        onChanged: (v) => vm.filterMiles.value = v,
                      ),
                    ),
                    bodyText(
                      '${vm.filterMiles.value.round()} miles',
                      size: 12,
                      color: Colors.white.withOpacity(0.85),
                    ),

                   const Spacer(),

                    // Apply button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: vm.applyFilters,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(
                              color: Color(0xFF9CA3AF), // #4F4F9E @ 62% alpha
                              width: 0.1,
                            ),
                          ),
                          // Alternatively, you can put the border here:
                          // side: const BorderSide(color: Color(0x9E4F4F9E), width: 1),
                        ),
                        child: headingText('Apply Filters', size: 14, color: Colors.white),
                      ),
                    )

                  ],
                );
              }),

            ),
          ),
        ),
      ),
    );
  }

  Widget _radioChip({
    required String label,
    required HgGender value,
    required HgGender group,
    required VoidCallback onTap,
  }) {
    final selected = value == group;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // little circular radio
          Container(
            width: 18, height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.9), width: 1.3),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              margin: const EdgeInsets.all(3.2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Colors.white : Colors.transparent,
              ),
            ),
          ),
          const SizedBox(width: 8),
          bodyText(label, size: 13, color: Colors.white.withOpacity(selected ? 1.0 : 0.75)),
        ],
      ),
    );
  }
}
