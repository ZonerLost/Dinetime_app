import 'package:canada/Constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_images.dart';
import '../Models/like_model.dart';
import '../view_model/likes_vm.dart';

// how tall your tabs/header look on screen (tweak 60–76 if needed)
const double _kLikesHeaderInset = 64.0;

class LikesView extends GetView<LikesVM> {
  const LikesView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LikesVM>()) {
      Get.put(LikesVM(), permanent: true);
    }


    return Obx(() {
      if (controller.profiles.isEmpty) {
        return const Center(
          child: Text('No likes yet', style: TextStyle(color: Colors.white70)),
        );
      }

      return SafeArea(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 15,
                 vertical: context.screenHeight * 0.1 - 20
          ),
          itemCount: controller.profiles.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final p = controller.profiles[index];
            return _LikeCard(
              profile: p,
              // onDislike: () => controller.removeCard(p.id),
              onLike: () => controller.toggleLike(p.id),
            );
          },
        ),
      );
    });
  }
}


class _LikeCard extends StatelessWidget {
  const _LikeCard({
    required this.profile,
    this.onDislike,
    required this.onLike,
  });

  final LikeProfile profile;
  final VoidCallback? onDislike;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return AspectRatio( 
      aspectRatio: 16 / 9.2, // tune if needed: lower → taller card
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // photo
            Image.asset(profile.photo, fit: BoxFit.cover),

            // top & bottom gradients (makes white text pop)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 84,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Color(0xAA000000), Color(0x00000000)],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 110,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter, end: Alignment.topCenter,
                    colors: [Color(0xBB000000), Color(0x00000000)],
                  ),
                ),
              ),
            ),

            // time pill (top-left)
            Positioned(
              left: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.transparent.withValues(alpha:  0.15),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  profile.timeAgo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // small X at top-right (like mock)
            Positioned(
              right: 12,
              top: 56,
              child: _roundIcon(
                svg: app_images.charm_cross,
                size: 35, // smaller than heart
                iconSize: 20,
                onTap: onDislike,
              ),
            ),

            // heart at mid-right
            Positioned(
              right: 0,
              top: 110,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _heartIcon(
                    selected: profile.liked,
                    onTap: onLike,
                  ),
                ),
              ),
            ),

            // bottom-left info block
            Positioned(
              left: 12,
              right: 90, // keep text away from side buttons
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${profile.name} ${profile.age}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.role,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(
                        app_images.location_pin,
                        width: 13, height: 19,

                      ),
                      const SizedBox(width: 6),
                      Text(
                        profile.city,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // small round icon (X)
// X button: transparent fill + soft white ring + white X
  Widget _roundIcon({
    required String svg,
    required double size,
    required double iconSize,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        decoration: BoxDecoration(
          color: Colors.transparent, // fully clear center
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.white70, width: 0.5), // soft white ring
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          svg, // e.g., app_images.charm_cross
          // width: iconSize,
          // height: iconSize,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }

// Heart button: transparent fill + pink ring + pink heart
  Widget _heartIcon({required bool selected, VoidCallback? onTap}) {
    const pink = Color(
        0xFFFF2D55); 

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: pink, width: 1.8), 
        ),
        
        child: SvgPicture.asset(
          app_images.red_heart, // your pink/red heart asset
         
          // If app_images.red_heart is NOT pink by default, uncomment:
          // colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn),
        ),
      ),
    );
  }
}

