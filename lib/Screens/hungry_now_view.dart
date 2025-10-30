import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';
import '../Models/hungry_now_model.dart';
import '../Widgets/dt_bottom_nav.dart';
import '../Widgets/mini_switch.dart';
import '../view_model/hungry_active_view_model.dart';
import '../view_model/hungry_now_view_model.dart';
import 'activate_now_view.dart';

class HungryNowView extends StatelessWidget {
  HungryNowView({super.key});

  // ——— constants ———
  static const _font = 'Helvetica';
  static const _bold = 'Helvetica-Bold';

  // ——— VM OUTSIDE build() ———
  final HungryNowVM vm = Get.put(
    HungryNowVM(
      HungryNowModel(
        topIcon:         app_images.ic_hungry_logo,
        settingsIcon:    app_images.ic_settings,
        avatarIcon:      app_images.ic_tab_profile,
        tabHungry:       app_images.ic_tab_hungry,
        tabDiscover:     app_images.ic_tab_discover,
        tabReservations: app_images.ic_tab_reservations,
        tabChat:         app_images.ic_tab_chat,
        tabProfile:      app_images.ic_tab_profile,
        checkIcon:       app_images.ic_check,
      ),
    ),
    permanent: true,
  );

  // shared asset helper (no closure allocation in build)
  static Widget _asset(String path, {double w = 22, double h = 22, Color? color}) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        width: w,
        height: h,
        colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
      );
    }
    return Image.asset(path, width: w, height: h, fit: BoxFit.cover, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final double horizontalPad   = w >= 1200 ? 32 : w >= 840 ? 24 : 16;
    final double contentMaxWidth = w >= 1200 ? 520 : w >= 840 ? 480 : 400;

    return Obx( () => vm.isOn.value ? ActivateNowView()  : Scaffold(
      backgroundColor: Colors.white,
      appBar: _TopBar(
        settingsIcon: vm.model.settingsIcon,
        avatarIcon:   vm.model.avatarIcon,
        onSettings:   vm.goSettings,
        onProfile:    vm.goProfile,
      ),

      // let the nav bar render under the bottom inset (no gap)
      extendBody: true,
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(horizontalPad, 8, horizontalPad, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentMaxWidth),
              child: Column(
                children: [
                  const SizedBox(height: 76),
                  _Emblem(iconPath: vm.model.topIcon),
                  const SizedBox(height: 16),

                  const Text(
                    'Hungry Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: _bold,
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: 8),
                  const Text(
                    'Activate hungry now to connect with people in your\narea who are ready to dine right now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: _font,
                      fontSize: 13,
                      color: AppColors.text,
                    ),
                  ),

                  const SizedBox(height: 32),

                  _ToggleRow(vm: vm),

                  const SizedBox(height: 36),

                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 340),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _BulletRow(iconPath: vm.model.checkIcon, text: 'Instant Matches With Active Users'),
                          _BulletRow(iconPath: vm.model.checkIcon, text: "See Who’s Hungry Nearby"),
                          _BulletRow(iconPath: vm.model.checkIcon, text: 'Chat And Meet Up Instantly'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // keep the glossy nav bar absolutely flush
    )
    );
  }
}

// ------------------ sub-widgets (stateless, cheap) ------------------

class _TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String settingsIcon;
  final String avatarIcon;
  final VoidCallback onSettings;
  final VoidCallback onProfile;

  const _TopBar({
    required this.settingsIcon,
    required this.avatarIcon,
    required this.onSettings,
    required this.onProfile,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const SizedBox.shrink(),
      actions: [
        IconButton(
          onPressed: onSettings,
          splashRadius: 18,
          icon: HungryNowView._asset(settingsIcon, w: 20, h: 20, color: AppColors.black),
        ),
        const SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: onProfile,
            child: ClipOval(
              child: HungryNowView._asset(avatarIcon, w: 24, h: 24, color: AppColors.black),
            ),
          ),
        ),
      ],
    );
  }
}

class _Emblem extends StatelessWidget {
  final String iconPath;
  const _Emblem({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Center(child: HungryNowView._asset(iconPath, w: 97, h: 97)),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final HungryNowVM vm;
  const _ToggleRow({required this.vm});


  static const _font = HungryNowView._font;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Off',
          style: TextStyle(
            fontFamily: _font,
            fontSize: 12,
            color: vm.isOn.value ? AppColors.greyshade1 : AppColors.black,
          ),
        ),
        const SizedBox(width: 8),
        MiniSwitch(
          value: vm.isOn.value,
          onChanged: (v) {
            vm.isOn.value = v;
            if (v && !Get.isRegistered<HungryActiveVM>()) {
              Get.put(createHungryActiveVm());
            }
            // if (v) {
            //   Get.to(
            //         () => ActivateNowView(),
            //     transition: Transition.cupertino,
            //     duration: const Duration(milliseconds: 220),
            //   );
            // }
          },
          width: 48,
          height: 28,
          activeColor: AppColors.black,
          inactiveColor: const Color(0xFFE0E0E0),
          semanticsLabel: 'Hungry Now toggle',
        ),
        const SizedBox(width: 8),
        Text(
          'On',
          style: TextStyle(
            fontFamily: _font,
            fontSize: 12,
            color: vm.isOn.value ? AppColors.black : AppColors.greyshade1,
          ),
        ),
      ],
    ));
  }
}

class _BulletRow extends StatelessWidget {
  final String iconPath;
  final String text;

  const _BulletRow({required this.iconPath, required this.text});

  static const _bold = HungryNowView._bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HungryNowView._asset(iconPath, w: 16, h: 16, color: AppColors.black),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontFamily: _bold,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                height: 1.35,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
