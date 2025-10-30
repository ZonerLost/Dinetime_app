// lib/Screens/discover_view.dart
import 'package:canada/Screens/spotlight_view.dart';
import 'package:canada/view_model/likes_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_images.dart';
import '../view_model/bio_viewmodel.dart';
import '../view_model/discover_viewmodel.dart';
    // ← separate view file
import '../view_model/hot&trending_vm.dart';
import '../view_model/spotlight_vm.dart';
import 'bio_view.dart';
import 'hot_trending_view.dart';
import 'likes_view.dart';

class DiscoverView extends GetView<DiscoverVM> {
  DiscoverView({super.key});

  @override
  DiscoverVM get controller => Get.put(DiscoverVM());
  final HotTrendingVM hotVM = Get.put(HotTrendingVM(), permanent: true);
// register VM once (like HotTrendingVM)
  final SpotlightVM spotlightVM = Get.put(SpotlightVM(), permanent: true);
  final LikesVM likesVM = Get.put(LikesVM(), permanent: true);
  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.paddingOf(context).bottom;
    final w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xff1C1C1C),
      body: Stack(
        children: [
      
          Positioned.fill(
            child: Obx(() {
              return IndexedStack(
                index: controller.tab.value.index,
                children: [
                  _buildPeople(context, paddingBottom, w),
                  const HotTrendingView(),          
                   SpotlightView(),
                  LikesView(),
                ],
              );
            }),
          ),
      
          // ---------- SEGMENTED HEADER + FILTER ----------
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Row(
                  children: [
                    Expanded(child: _tabsBar()),
                    const SizedBox(width: 2),
                    _filterIconSvg(onTap: controller.openFilter),
                    const SizedBox(width: 12),
      
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- TABS BAR --------------------
  Widget _tabsBar() {
    final items = [
      ['People', DiscoverTab.people],
      ['Hot & Trending', DiscoverTab.hotTrending],
      ['Spotlight', DiscoverTab.spotlight],
      ['Likes', DiscoverTab.likes],
    ];

    return Obx(() {
      return  Row(
        children: items.map((row) {
          final label = row[0] as String;
          final tab = row[1] as DiscoverTab;
          final selected = controller.tab.value == tab;
      
          return GestureDetector(
            onTap: () => controller.setTab(tab),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(19),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }).toList(growable: false),
      );
    });
  }

  // -------------------- PEOPLE (existing) --------------------
  Widget _buildPeople(BuildContext context, double paddingBottom, double w) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Obx(() => Image.asset(controller.photo, fit: BoxFit.cover)),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 140,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xCC000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 240,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xE6000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          left: 16,
          right: 16,
          bottom: 16 + paddingBottom,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.nameAge,
                  style: const TextStyle(
                    fontFamily: 'Helvetica-Bold',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _svg(app_images.tdesign_location, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      '${_fmtMiles(controller.milesAway)} miles away',
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'In For:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Helvetica-Bold',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: controller.inFor.map((t) => _chip(t)).toList(),
                      ),
                    ),
                    const SizedBox(width: 8),
            // suppose you have the current DiscoverProfile in `controller.profile.value`
            _roundIcon(
            app_images.info,
            size: 31,
            onTap: () {
            final d = controller.profile.value;
            if (d != null) controller.openInfo(d);
            },
            ),

            ],
                ),
                const SizedBox(height: 15),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.to(
                            () => const BioView(),
                        binding: BindingsBuilder(() {
                          if (!Get.isRegistered<BioVM>()) Get.put(BioVM());
                        }),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Looking for a fun dinner spot tonight!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica',
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: controller.showInfo.value
                      ? const SizedBox(
                          key: ValueKey('actions-hidden'),
                          height: 0,
                        )
                      : Column(
                          key: const ValueKey('actions-visible'),
                          children: [
                            SizedBox(height: w < 360 ? 8 : 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _actionButton(app_images.cross, onTap: controller.dislike),
                                _actionButton(app_images.thunder, onTap: controller.superLike, big: true),
                                _actionButton(app_images.sparkles, onTap: controller.spark, big: true),
                                _actionButton(app_images.like, onTap: controller.like),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                ),
              ],
            );
          }),
        ),
        Obx(() {
          final show = controller.showInfo.value;
          return Positioned.fill(
            child: IgnorePointer(
              ignoring: !show,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 320),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final slideAnim = Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                    reverseCurve: Curves.easeInCubic,
                  ));
                  return SlideTransition(
                    position: slideAnim,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: show
                    ? WillPopScope(
                        key: const ValueKey('discover-info-overlay'),
                        onWillPop: () async {
                          controller.closeInfo();
                          return false;
                        },
                        child: BioView(onClose: controller.closeInfo),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          );
        }),
      ],
    );
  }


  // -------------------- helpers --------------------
  Widget _filterIconSvg({VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.85),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            app_images.white_filter,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  static String _fmtMiles(double m) =>
      (m % 1.0 == 0) ? m.toStringAsFixed(0) : m.toStringAsFixed(1);

  static Widget _svg(String path, {double size = 16}) =>
      SvgPicture.asset(path, width: size, height: size);

  static String? _chipIconFor(String label) {
    switch (label) {
      case 'Dine':
        return app_images.lucidelab_forkknife;
      case 'Split':
      case 'People':
        return app_images.ion_people;
      case 'Female':
      case 'Person':
        return app_images.linemd_person;
      default:
        return null;
    }
  }

  static Widget _chip(String text) {
    final iconPath = _chipIconFor(text);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.85),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconPath != null) ...[
            _svg(iconPath, size: 16),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _actionButton(String asset, {VoidCallback? onTap, bool big = false}) {
    return InkResponse(
      onTap: onTap,
      radius: 35,
      child: Container(
        width: 54,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.070),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: _svg(asset, size: big ? 30 : 24),
      ),
    );
  }

  Widget _roundIcon(
      String asset, {
        double size = 31,
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0x66000000), // 40% black
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          asset,
          width: size * 0.54,
          height: size * 0.54,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }

}

// tiny inline dock button (kept inside this file; no new class files)
