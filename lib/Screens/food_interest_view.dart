import 'package:canada/Constants/main_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/app_colors.dart';
import '../Routes/app_routes.dart';
import '../view_model/food_interest_view_model.dart';

class FoodInterestView extends StatelessWidget {
  const FoodInterestView({super.key});

  static const String kFont = 'Helvetica';
  static const String kFontBold = 'Helvetica-Bold';

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(FoodInterestViewModel());


    Widget pill(String label, bool selected, VoidCallback onTap, double width) {
      return SizedBox(
        width: width,
        height: 40,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: selected ? AppColors.black : Colors.white,
            side: BorderSide(
              color: selected ? AppColors.black : const Color(0xFFE6E6E6),
              width: 1,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            foregroundColor: selected ? Colors.white : AppColors.black,
          ).copyWith(
            overlayColor: MaterialStatePropertyAll(
              (selected ? Colors.white : AppColors.black).withOpacity(0.06),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: kFontBold,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.0,
              color: selected ? Colors.white : AppColors.greyshade4,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Center(
                child: const Text(
                  'What Food Do You Love?',
                  style: TextStyle(
                    fontFamily: kFontBold,
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    height: 1.1,
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 25),
            
              // Subtext
              const Text(
                'Select your favourite cuisines to share with potential matches',
                style: TextStyle(
                  fontFamily: kFont,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.2,
                  color: AppColors.greyshade2,
                ),
              ),
              const SizedBox(height: 18),
            
              // Counter
              Obx(() => Text(
                '${vm.selected.length} Selected',
                style: const TextStyle(
                  fontFamily: kFont,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.0,
                  color:AppColors.black ,
                ),
              )),
              const SizedBox(height: 12),
            
              // Grid (two columns)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, cs) {
                    const spacing = 12.0;
                    const cols = 2;
                    final chipW = (cs.maxWidth - spacing * (cols - 1)) / cols;
            
                    return Obx(() => SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: vm.options.map((label) {
                          final sel = vm.isSelected(label);
                          return pill(label, sel, () => vm.toggle(label), chipW);
                        }).toList(),
                      ),
                    ));
                  },
                ),
              ),
            
              // Save button
              SizedBox(
                width: double.maxFinite,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    await vm.save();
                    Get.offAll(() => MainNavView()); // ← go to Sign Up
                  },
            
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(AppColors.black),
                    foregroundColor: const MaterialStatePropertyAll(Colors.white),
                    overlayColor: MaterialStatePropertyAll(AppColors.black.withOpacity(0.08)),
                    elevation: const MaterialStatePropertyAll(0),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: kFontBold,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
