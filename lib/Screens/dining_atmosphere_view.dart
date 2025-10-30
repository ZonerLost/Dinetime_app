import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';
import '../Routes/app_routes.dart';
import '../Models/dining_atmosphere_model.dart';
import '../view_model/dining_atmosphere_view_model.dart';

class DiningAtmosphereView extends StatefulWidget {
  const DiningAtmosphereView({super.key});

  // body text family
  static const String kFontFamily = 'Helvetica';
  // HEADINGS family (your Helvetica-Bold.ttf)
  static const String kHeadingFamily = 'Helvetica-Bold';

  @override
  State<DiningAtmosphereView> createState() => _DiningAtmosphereViewState();
}

class _DiningAtmosphereViewState extends State<DiningAtmosphereView> {
  static const _pad = 16.0;
  static const _radius = 12.0;

  late final DiningAtmosphereViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = Get.isRegistered<DiningAtmosphereViewModel>()
        ? Get.find<DiningAtmosphereViewModel>()
        : Get.put(DiningAtmosphereViewModel(DiningAtmosphereModel.defaultOptions()));
  }

  TextStyle get _h1 => const TextStyle(
    fontFamily: DiningAtmosphereView.kHeadingFamily,
    fontSize: 26,            // larger like the mock
    fontWeight: FontWeight.w700,
    height: 1.0,             // 100% line-height
    color: AppColors.black,
  );

  TextStyle get _q => const TextStyle(
    fontFamily: DiningAtmosphereView.kHeadingFamily,
    fontSize: 26,            // big question like the mock
    fontWeight: FontWeight.w700,
    height: 1.0,
    color: AppColors.black,
  );

  // Button text
  TextStyle get _btn => const TextStyle(
    fontFamily: DiningAtmosphereView.kFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // A single radio-like pill
  Widget _option(String label) {
    return Obx(() {
      final selected = vm.isSelected(label);
      return InkWell(
        onTap: () => vm.pick(label),
        borderRadius: BorderRadius.circular(_radius),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_radius),
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 6)),
            ],
            border: Border.all(
              color: selected ? AppColors.black : const Color(0xFFE5E7EB),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // FULL black circle when selected
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.black : Colors.white,
                  border: selected ? null : Border.all(color: AppColors.black, width: 1.5),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: DiningAtmosphereView.kFontFamily,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Illustration under options
  Widget _illustration() {
    const plate = Color(0xFF4B5563);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant, size: 28, color: plate),
          const SizedBox(width: 16),
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: plate, width: 6)),
            child: const Center(child: Icon(Icons.favorite, size: 40, color: plate)),
          ),
          const SizedBox(width: 16),
          Icon(Icons.restaurant_menu, size: 28, color: plate),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontFamily: DiningAtmosphereView.kFontFamily),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: _pad),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text('Your Food Interest', style: _h1, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: 0.45,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFE9EAEB),
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
                  ),
                ),
                const SizedBox(height: 22),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "What’s your ideal dining\natmosphere?",
                        style: _q,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(app_images.dining_hearts, width: 46, height: 41, fit: BoxFit.contain),
                  ],
                ),
                const SizedBox(height: 18),

                LayoutBuilder(
                  builder: (_, __) {
                    final opts = vm.model.options;
                    return Column(
                      children: [
                        for (int i = 0; i < opts.length; i += 2) ...[
                          Row(
                            children: [
                              Expanded(child: _option(opts[i])),
                              const SizedBox(width: 12),
                              if (i + 1 < opts.length) Expanded(child: _option(opts[i + 1])),
                              if (i + 1 >= opts.length) const Expanded(child: SizedBox.shrink()),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ],
                    );
                  },
                ),

                _illustration(),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {
                      await vm.save();
                      Get.offAllNamed(AppRoutes.home);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor: MaterialStateProperty.all(AppColors.black.withOpacity(0.08)),
                      elevation: const MaterialStatePropertyAll(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    child: Text('Save & Continue', style: _btn),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
