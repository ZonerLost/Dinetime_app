import 'package:canada/Constants/responsive.dart';
import 'package:canada/Widgets/custom_text_widget.dart';
import 'package:canada/Widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';
import '../Models/hungry_now_model.dart';
import '../Widgets/mini_switch.dart';
import '../view_model/hungry_active_view_model.dart';
import '../view_model/hungry_now_view_model.dart';
import 'activate_now_view.dart';
import 'hungry_active_view.dart';

class HungryNowView extends StatelessWidget {
  HungryNowView({super.key});

  // ——— constants ———
  static const _font = 'Helvetica';
  static const _bold = 'Helvetica-Bold';

  // ——— VM OUTSIDE build() ———
  final HungryNowVM vm = Get.put(
    HungryNowVM(
      HungryNowModel(
        topIcon:         app_images.cutleryIcon,
        settingsIcon:    app_images.ic_settings,
        avatarIcon:      app_images.ic_tab_profile,
        tabHungry:       app_images.ic_tab_hungry,
        tabDiscover:     app_images.ic_tab_discover,
        tabReservations: app_images.ic_tab_reservations,
        tabChat:         app_images.ic_tab_chat,
        tabProfile:      app_images.ic_tab_profile,
        checkIcon:       app_images.checkCircleIcon,
        chatIcon:         app_images.cahtsIcon, 
        locationIcon:     app_images.locationPinIcon
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

  Widget _buildLanding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final double horizontalPad   = w >= 1200 ? 32 : w >= 840 ? 24 : 30;
    // final double contentMaxWidth = w >= 1200 ? 520 : w >= 840 ? 480 : 400;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _TopBar(
        settingsIcon: vm.model.settingsIcon,
        avatarIcon:   vm.model.avatarIcon,
        onSettings:   vm.goSettings,
        onProfile:    vm.goProfile,
      ),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal:  horizontalPad, vertical:  24),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle, 
                  border: Border.all(color: AppColors.black_text.withValues(alpha: 0.17))
                ),
             child:  HungryNowView._asset(vm.model.topIcon, w: 60, h: 60)
                
              ),                
              const SpacerWidget(height: 2),
              const CustomTextWidget(
                text:  'Hungry Now',
                textAlign: TextAlign.center,
                
                  fontFamily: _bold,
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  color: AppColors.black,
                
              ),
              const SpacerWidget(height: 1),
              const CustomTextWidget(
               text:  'Meet people ready to dine right now',
                textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  fontFamily: _font,
                  fontSize: 14,
                  color: AppColors.text,
                
              ),
              const SpacerWidget(height: 4),
              _ToggleRow(vm: vm),
              const SpacerWidget(height: 4),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: CustomTextWidget(text: "Features", fontWeight: FontWeight.bold, fontSize: 18,)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _BulletRow(iconPath: vm.model.checkIcon, text: 'Instant Matches With Active Users'),
                  _BulletRow(iconPath: vm.model.locationIcon!, text: "See Who’s Hungry Nearby"),
                  _BulletRow(iconPath: vm.model.chatIcon!, text: 'Chat And Meet Up Instantly'),
                ],
              ),
              SpacerWidget(height: 3), 
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.gray200.withValues(alpha: 0.15), 
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const CustomTextWidget(
                 text:  'When you turn this on, your profile becomes visible to people who also want to dine now.',
                  textAlign: TextAlign.center,
                 
                    fontFamily: _font,
                    fontSize: 14,
                    color: AppColors.text,
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (vm.subPage.value) {
        case HungrySubPage.landing:
          return _buildLanding(context);
        case HungrySubPage.activateNow:
          return ActivateNowView(hostVm: vm);
        case HungrySubPage.hungryActive:
          return HungryActiveView(hostVm: vm);
      }
    });
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
      // title: const SizedBox.shrink(),
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
            child: CircleAvatar(radius: 18, 
            backgroundImage: AssetImage(app_images.picture1), backgroundColor: Color(0xFFDDDDDD)),

          ),
        ),
      ],
    );
  }
}


class _ToggleRow extends StatelessWidget {
  final HungryNowVM vm;
  const _ToggleRow({required this.vm});



  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      width: context.screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      // margin: EdgeInsets.symmetric(horizontal: 19),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.blackshade1.withValues(alpha: 0.2))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Expanded(child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              CustomTextWidget(text: "Hungry Now Mode", fontWeight: FontWeight.bold,
             fontSize: 16,
              ),
              CustomTextWidget(text: "Turn on to go live", fontWeight: FontWeight.normal,
             fontSize: 14,
              )
            ],)),
          
          const SizedBox(width: 8),
          MiniSwitch(
            value: vm.isOn.value,
            onChanged: (v) {
              vm.toggle(v);
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
          
        ],
      ),
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray200.withValues(alpha: 0.4)), 
        borderRadius: BorderRadius.circular(18)
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle, 
              border: Border.all(color: AppColors.black.withValues(alpha: 0.1))
            ),
            child: HungryNowView._asset(iconPath, w: 15, h: 15, 
            color: AppColors.black)),
          const SizedBox(width: 12),
          Flexible(
            child: CustomTextWidget(
              text:  text,
              textAlign: TextAlign.start,
                fontFamily: _bold,
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: AppColors.black,
              
            ),
          ),
        ],
      ),
    );
  }
}
