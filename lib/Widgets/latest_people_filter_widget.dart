import 'package:canada/Constants/app_colors.dart';
import 'package:canada/Constants/responsive.dart';
import 'package:canada/Widgets/custom_text_widget.dart';
import 'package:canada/view_model/spotlight_vm.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SpotLightBottomSheet extends StatelessWidget {
  const SpotLightBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final spotlightVm = Get.find<SpotlightVM>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.black_text,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Title
          const CustomTextWidget(
           text:  'Filter Spotlight',
              color: AppColors.background,
              fontSize: 20, 
              fontWeight: FontWeight.w600,
            
          ),
          const SizedBox(height: 20),

          // Filter Dropdown with Obx
          Obx(() => SimpleFilterDropdown(
                value: spotlightVm.filter.value,
                onChanged: (filter) {
                  spotlightVm.filter.value = filter;
                  // Optional: Close bottom sheet after selection
                  // Navigator.pop(context);
                },
              )),

          const SizedBox(height: 20),

          // Apply Button (Optional)
          GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: CustomTextWidget(
                         text:  'Apply Filters',
                            color: AppColors.background,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}



class SimpleFilterDropdown extends StatelessWidget {
  const SimpleFilterDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final SpotlightFilter value;
  final ValueChanged<SpotlightFilter> onChanged;

  // Helper method to get display text for each filter
  String _getFilterDisplayText(SpotlightFilter filter) {
    switch (filter) {
      case SpotlightFilter.latestInArea:
        return 'Latest in Your Area';
      case SpotlightFilter.peopleYouFollow:
        return 'People You Follow';
      default:
        return filter.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SpotlightFilter>(
      color: AppColors.black_text,
      surfaceTintColor: Colors.transparent,
      onSelected: onChanged,
      itemBuilder: (_) => const [
        PopupMenuItem(
          value:  SpotlightFilter.latestInArea,
          child: CustomTextWidget(
            text: 'Latest in Your Area', 
            color: AppColors.background,
          ),
        ),
        PopupMenuItem(
          value: SpotlightFilter.peopleYouFollow,
          child: CustomTextWidget(
            text: 'People You Follow', 
            color: AppColors.background,
          ),
        ),
      ],
      child: Container(
        width: context.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: 0.6),
         
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              text: _getFilterDisplayText(value),
              color: AppColors.background,
              fontSize: 16,
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_drop_down, 
              color: AppColors.background,
            ),
          ],
        ),
      ),
    );
  }
}