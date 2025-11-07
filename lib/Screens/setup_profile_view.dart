import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';
import '../Constants/responsive.dart';
import '../Models/setup_profile_model.dart' as m;
import '../Routes/app_routes.dart';
import '../Widgets/Drop-in inline dropdown.dart';
import '../Widgets/mini_switch.dart';
import '../Widgets/custom_text_widget.dart';
import '../view_model/setup_profile_view_model.dart';

class SetupProfileView extends StatelessWidget {
  SetupProfileView({super.key});

  // Put VM once, not in build.
  final SetupProfileViewModel vm =
  Get.put(SetupProfileViewModel(const m.SetupProfileModel(maxPhotos: 6)),
      permanent: true);

  // About box decoration (Helvetica regular for hint)
  InputDecoration _aboutBoxDecoration() => InputDecoration(
    hintText: 'Tell us about yourself...',
    hintStyle: const TextStyle(
      fontFamily: kFontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1,
      color: Color(0xFFB3B3B3),
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
    ),
  );

  // Photo tile (dotted empty -> image)
  Widget _photoTile(BuildContext context, int i) => InkWell(
    onTap: () => vm.pickPhoto(i),
    borderRadius: BorderRadius.circular(16),
    child: Obx(() {
      final file = vm.photos[i];
      if (file == null) {
        return DottedBorder(
          color: AppColors.lightgray,
          strokeWidth: 1.5,
          dashPattern: const [6, 4],
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          child: Container(
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/image_picker.svg',
                width: R.w(context, 6),
                height: R.w(context, 6),
                colorFilter: const ColorFilter.mode(
                    AppColors.gray200, BlendMode.srcIn),
              ),
            ),
          ),
        );
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(File(file.path), fit: BoxFit.cover),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: R.h(context, 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.purple500.withOpacity(0.35),
                      AppColors.purple500.withOpacity(0.75),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }),
  );

  // Tabs (Edit / Preview) – underline follows selection, padded from edges.
  Widget _tabStrip(BuildContext context) => Obx(() {
    final selected = vm.tabIndex.value;

    // Tuned to your mock
    const double fontSize = 15.5;
    const double underlineH = 1.25;
    const double underlineW = 96; // length under selected tab
    const double gap = 6;
    final double horizontalEdge = R.w(context, 6);

    Widget tab(String label, int index) {
      final isSelected = selected == index;
      return InkWell(
        onTap: () => vm.setTab(index), // event-time mutation (safe)
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextWidget(
                text: label,
                fontFamily: isSelected ? kBoldFont : kFontFamily,
                fontWeight:
                isSelected ? FontWeight.w700 : FontWeight.w400,
                fontSize: fontSize,
                color: isSelected
                    ? AppColors.black
                    : AppColors.black.withOpacity(0.70),
              ),
              const SizedBox(height: gap),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: underlineH,
                width: isSelected ? underlineW : 0,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalEdge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          tab('Edit', 0),
          tab('Preview', 1),
        ],
      ),
    );
  });

  // Smart Photos row
  Widget _smartPhotosRow(BuildContext context) => Obx(() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label + description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomTextWidget(
                text: 'Smart Photos',
                fontFamily: kBoldFont,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.greyshade1,
                height: 1,
              ),
              SizedBox(height: 8),
              CustomTextWidget(
                text:
                'Continuously tests all your profile photos and picks the best one to show first',
                fontFamily: kFontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.greyshade2,
                height: 1.2,
              ),
            ],
          ),
        ),
        SizedBox(width: R.w(context, 2)),
        Padding(
          padding: EdgeInsets.only(top: R.h(context, 1.8)),
          child: MiniSwitch(
            value: vm.smartPhotos.value,
            onChanged: vm.toggleSmartPhotos,
            width: 38,
            height: 21.375,
            activeColor: Colors.black,
            inactiveColor: AppColors.greyshade2,
            opacity: 1.0,
          ),
        ),
      ],
    );
  });

  @override
  Widget build(BuildContext context) {
    final double sidePad = R.w(context, 5);
    final double topPad = R.h(context, 2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: sidePad, vertical: topPad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: headingText('Profile', size: 26)),
              SizedBox(height: R.h(context, 2)),
            
              _tabStrip(context),
              SizedBox(height: R.h(context, 2)),
            
              Padding(
                padding: EdgeInsets.symmetric(vertical: R.h(context, 1)),
                child: headingText('My Photos & Video', size: 18),
              ),
              SizedBox(height: R.h(context, 1.4)),
            
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vm.model.maxPhotos,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: R.w(context, 3),
                  crossAxisSpacing: R.w(context, 3),
                  childAspectRatio: 1,
                ),
                itemBuilder: (_, i) => _photoTile(context, i),
              ),
            
              SizedBox(height: R.h(context, 1.2)),
              Center(
                child: bodyText(
                  'Tap to edit, drag to reorder',
                  size: 13,
                  color: AppColors.black,
                ),
              ),
            
              SizedBox(height: R.h(context, 3)),
            
              const CustomTextWidget(
                text: 'PHOTO OPTIONS',
                fontFamily: kBoldFont,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.greyshade3,
                height: 1,
              ),
              SizedBox(height: R.h(context, 2.2)),
              _smartPhotosRow(context),
            
              SizedBox(height: R.h(context, 3)),
            
              const CustomTextWidget(
                text: 'ABOUT ME',
                fontFamily: kBoldFont,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.greyshade3,
                height: 1,
              ),
              SizedBox(height: R.h(context, 1.4)),
              TextField(
                controller: vm.aboutCtrl,
                minLines: 4,
                maxLines: 6,
                maxLength: 500,
                style: const TextStyle(
                  fontFamily: kFontFamily,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1,
                  color: AppColors.text,
                ),
                decoration: _aboutBoxDecoration(),
                buildCounter: (context,
                    {required int currentLength,
                      required bool isFocused,
                      int? maxLength}) {
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '${currentLength}/${maxLength ?? 500}',
                      style: const TextStyle(
                        fontFamily: kFontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  );
                },
              ),
            
              SizedBox(height: R.h(context, 3)),
            
              const CustomTextWidget(
                text: 'LINK INSTAGRAM',
                fontFamily: kBoldFont,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.greyshade3,
                height: 1,
              ),
              SizedBox(height: R.h(context, 1.4)),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 366,
                  height: 46,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF8A3AB9),
                          Color(0xFFF56040),
                          Color(0xFFFF7A00)
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: vm.linkInstagram,
                      style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(0),
                        backgroundColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                        shadowColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                        overlayColor: MaterialStatePropertyAll(
                            Colors.white.withOpacity(0.08)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(app_images.instagram_icon,
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn)),
                          const SizedBox(width: 12),
                          const CustomTextWidget(
                            text: 'LINK YOUR INSTAGRAM',
                            fontFamily: kBoldFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            
              SizedBox(height: R.h(context, 3)),
            
              const CustomTextWidget(
                text: 'AGE',
                fontFamily: kBoldFont,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.greyshade3,
                height: 1,
              ),
              SizedBox(height: R.h(context, 1.2)),
              Obx(() => InlineDropdown<int>(
                value: vm.age.value,
                options: vm.ages,
                placeholder: 'Select your age',
                labelOf: (a) => '$a',
                onChanged: (v) => vm.age.value = v,
              )),
            
              SizedBox(height: R.h(context, 2.2)),
            
              const CustomTextWidget(
                text: 'GENDER',
                fontFamily: kBoldFont,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.greyshade3,
                height: 1,
              ),
              SizedBox(height: R.h(context, 0.8)),
              Obx(() => InlineDropdown<m.Gender>(
                value: vm.selectedGender.value,
                options: m.Gender.values,
                placeholder: 'Select your gender',
                labelOf: vm.labelOf,
                onChanged: vm.setGender,
              )),
            
              SizedBox(height: R.h(context, 3)),
            
              const CustomTextWidget(
                text: 'FAVORITE CUISINES',
                fontFamily: kBoldFont,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.greyshade3,
                height: 1,
              ),
              SizedBox(height: R.h(context, 0.8)),
              bodyText(
                'Select your favourite cuisines to share with\npotential matches',
                size: 14,
                color: AppColors.greyshade2,
                height: 1.2,
              ),
              SizedBox(height: R.h(context, 2)),
            
              LayoutBuilder(builder: (context, c) {
                const spacing = 12.0;
                const cols = 2;
                final chipW =
                    (c.maxWidth - spacing * (cols - 1)) / cols;
            
                return Obx(() => Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: vm.cuisines.map((name) {
                    final selected =
                    vm.selectedCuisines.contains(name);
                    return SizedBox(
                      width: chipW,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () => vm.toggleCuisine(name),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: selected
                              ? AppColors.black
                              : Colors.white,
                          side: BorderSide(
                              color: selected
                                  ? AppColors.black
                                  : const Color(0xFFE6E6E6)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          foregroundColor: selected
                              ? Colors.white
                              : AppColors.black,
                        ),
                        child: CustomTextWidget(
                          text: name,
                          fontFamily: kBoldFont,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: selected
                              ? Colors.white
                              : AppColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ));
              }),
            
              SizedBox(height: R.h(context, 2)),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.foodInterest),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CustomTextWidget(
                      text: 'View All food Interests',
                      fontFamily: kBoldFont,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.greyshade4,
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.chevron_right,
                        size: 18, color: AppColors.black),
                  ],
                ),
              ),
            
              SizedBox(height: R.h(context, 3)),
            
              const CustomTextWidget(
                text: 'HOBBIES',
                fontFamily: kBoldFont,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.greyshade3,
                height: 1,
              ),
              SizedBox(height: R.h(context, 0.8)),
              bodyText(
                'Select your hobbies to share with potential matches',
                size: 14,
                color: AppColors.greyshade2,
                height: 1.2,
              ),
              SizedBox(height: R.h(context, 2)),
            
              LayoutBuilder(builder: (context, c) {
                const spacing = 12.0;
                const cols = 2;
                final chipW =
                    (c.maxWidth - spacing * (cols - 1)) / cols;
            
                return Obx(() => Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: vm.hobbies.map((h) {
                    final selected =
                    vm.selectedHobbies.contains(h);
                    return SizedBox(
                      width: chipW,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () => vm.toggleHobby(h),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: selected
                              ? AppColors.black
                              : Colors.white,
                          side: BorderSide(
                              color: selected
                                  ? AppColors.black
                                  : const Color(0xFFE6E6E6)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          foregroundColor: selected
                              ? Colors.white
                              : AppColors.black,
                        ),
                        child: CustomTextWidget(
                          text: h,
                          fontFamily: kBoldFont,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: selected
                              ? Colors.white
                              : AppColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ));
              }),
            
              SizedBox(height: R.h(context, 3)),
              Center(
                child: SizedBox(
                  width: double.maxFinite,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: vm.saveAndGoNext,
                    style: ButtonStyle(
                      backgroundColor:
                      const WidgetStatePropertyAll(AppColors.black),
                      foregroundColor:
                      const WidgetStatePropertyAll(AppColors.white),
                      overlayColor: WidgetStatePropertyAll(
                          AppColors.black.withOpacity(0.08)),
                      elevation: const WidgetStatePropertyAll(0),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                    ),
                    child: const CustomTextWidget(
                      text: 'Save',
                      fontFamily: kBoldFont,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
