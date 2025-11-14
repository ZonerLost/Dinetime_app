import 'dart:math';
import 'package:canada/Constants/responsive.dart';
import 'package:canada/view_model/hungry_now_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_images.dart';
import '../Widgets/custom_text_widget.dart'; // headingText/bodyText + fonts
import '../Widgets/filter_sheet.dart';
import '../Widgets/mini_switch.dart';

import '../Models/hungry_active_model.dart';
import '../Models/hungry_now_model.dart';
import '../view_model/hungry_active_view_model.dart';

class HungryActiveView extends StatelessWidget {
   HungryActiveView({super.key, HungryNowVM? hostVm})
     : navVm = hostVm ?? _resolveHungryVm();

  final RxInt _navIndex = 0.obs;
  final HungryNowVM navVm;

  static HungryNowVM _resolveHungryVm() {
    if (Get.isRegistered<HungryNowVM>()) {
      return Get.find<HungryNowVM>();
    }
    return Get.put(
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
    );
  }


  Widget _headerBar(BuildContext context, HungryActiveVM vm) {
    final side = context.screenWidth >= 420 ? 16.0 : 12.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(side, 6, side, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/images/logo3.svg',
              width: 36, height: 32,
              //colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 10),
          headingText('Hungry Now', size: 20),
          const Spacer(),

          const SizedBox(width: 12),
          Obx(() => MiniSwitch(
            value: vm.isOn.value,
            onChanged: (v){
              vm.toggleOn(v);
              if (v) {
                navVm.showHungryActive();
              } else {
                navVm.showLanding();
              }
            },
            width: 38, height: 21.375,
            activeColor: AppColors.black,
            inactiveColor: const Color(0xFFE0E0E0),
            semanticsLabel: 'Hungry Now toggle',
          )),
        ],
      ),
    );
  }


  Widget _viewChatCard(BuildContext context, HungryActiveVM vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // centered full-width card
          Container(
            height: 40,
            width: double.infinity, // <- fill available width so left/right space is equal
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE6E6E6)),
              borderRadius: BorderRadius.circular(4),
            ),
            // center icon + label
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // <- center content
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Center(
                    child: SvgPicture.asset(
                      app_images.ic_tab_chat,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        AppColors.greyshade2,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                bodyText(
                  'View Chat',
                  size: 14,
                  color: AppColors.greyshade6,
                  weight: FontWeight.w700, // <- bold
                )
              ],
            ),
          ),

          // keep the full-card tap
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: vm.viewChat,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _sectionHeader(BuildContext context, HungryActiveVM vm, int countNearby) {
    final w = MediaQuery.of(context).size.width;
    final side = w >= 420 ? 16.0 : 12.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(side, 16, side, 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headingText('Active Now', size: 22),
              const SizedBox(height: 2),
              bodyText('4 People nearby and ready to dine', size: 13, color: AppColors.text),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => vm.openFilter(
              context,
              sheet: FilterSheet(vm: vm), // your bottom-sheet widget
            ),
            icon: SvgPicture.asset(app_images.mi_filter, width: 24, height: 24),
          )

        ],
      ),
    );
  }


  Widget _personCard(BuildContext context, HungryActiveVM vm, HungryActivePerson p) {
    const radius = 4.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Stack(
              children: [
                const AspectRatio(aspectRatio: 1),
                Positioned.fill(
                  child: Image.asset(
                    app_images.picture1,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: headingText('Dine', size: 12, color: Colors.white),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54, Colors.black87],
                        stops: [0.3, 0.75, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bodyText('${p.name} ${p.age}', size: 24, color: Colors.white),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            app_images.tdesign_location, // your SVG
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 6),
                          bodyText(p.distance, size: 16, color: Colors.white70),
                        ],
                      ),
                      const SizedBox(height: 6, width: 6),
                      bodyText(p.blurb, size: 15, color: Colors.white70),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 290,
              height: 38,
              child: ElevatedButton(
                onPressed: () => vm.message(p),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // ✅ no overflow
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center, // ✅ centered
                  children: [
                    SvgPicture.asset(app_images.white_chat, height: 18),
                    const SizedBox(width: 10),
                    headingText('Message', size: 12, color: Colors.white),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  final HungryActiveVM vm = Get.isRegistered<HungryActiveVM>()
      ? Get.find<HungryActiveVM>()
      : Get.put(createHungryActiveVm());
  
  @override
  Widget build(BuildContext context) {
    const double maxContent = 420;
    const double bottomNavHeight = 64;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,


      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const SizedBox.shrink(),
        toolbarHeight: 56,
        actions: [
          const SizedBox(width: 8),
          IconButton(

            splashRadius: 18,
            icon: const Icon(Icons.settings, size: 24, color: Colors.black), onPressed: () {  },
          ),


        GestureDetector(
         // optional
          child:  CircleAvatar(radius: 18, backgroundImage: AssetImage(app_images.picture1), backgroundColor: Color(0xFFDDDDDD)),

        ),

        const SizedBox(width: 12),
        ],
      ),

      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: bottomNavHeight + 16 + MediaQuery.of(context).padding.bottom,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxContent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _headerBar(context, vm),
                  const SizedBox(height: 6),
                  _viewChatCard(context, vm),
                  _sectionHeader(context, vm, vm.model.people.length),
                  const SizedBox(height: 8),
                  ...List.generate(3, (i) => vm.model.people[i % vm.model.people.length])
                      .expand((p) => [
                    _personCard(context, vm, p),
                    const SizedBox(height: 18),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),



    );
  }
}
