// lib/Screens/bio_view.dart
import 'dart:ui' show ImageFilter;
import 'package:canada/Constants/app_colors.dart';
import 'package:canada/Constants/responsive.dart';
import 'package:canada/Widgets/expanded_list_tile_widget.dart';
import 'package:canada/Widgets/glass_widget.dart';
import 'package:canada/Widgets/image_preview_dialog_widget.dart';
import 'package:canada/Widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_images.dart';
import '../Widgets/custom_text_widget.dart'; // headingText / bodyText
import '../view_model/bio_viewmodel.dart';

class BioView extends GetView<BioVM> {
  const BioView({super.key, this.onClose});
  final VoidCallback? onClose;
  @override
  BioVM get controller => Get.find<BioVM>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final topPad = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        final p = controller.profile.value;
        if (p == null) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        final heroH = (size.height * 0.70).clamp(440.0, 580.0);

        final handleClose = onClose ?? Get.back;

       return CustomScrollView(
            physics: const BouncingScrollPhysics(), 
            slivers: [
            // ---------------- HERO ----------------
            SliverToBoxAdapter(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: heroH,
                    width: size.width,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          p.heroPhoto,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: Container(
                        //     height: heroH * 0.42,
                        //     decoration: const BoxDecoration(
                        //       gradient: LinearGradient(
                        //         begin: Alignment.bottomCenter,
                        //         end: Alignment.topCenter,
                        //         colors: [Color(0xE6000000), Color(0x00000000)],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: topPad + context.screenHeight * 0.08,
                    child: _RoundSvgButton(
                      svgAsset: app_images.back_icon,
                      onTap: handleClose,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: headingText('${p.name} ${p.age}', size: 22, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        GlassWidget(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                app_images.locationIcon,
                                width: 16,
                                height: 16,
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              ),
                              const SizedBox(width: 6),
                              bodyText(
                                controller.milesLabel,
                                size: 12.5,
                                color: Colors.white,
                                weight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Overlapping Bio card
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: -56,
                    child: GlassCard(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                      borderRadius: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingText('Bio', size: 14, color: Colors.white),
                          const SizedBox(height: 8),
                          bodyText(
                            p.bio,
                            size: 13.5,
                            color: Colors.white70,
                            height: 1.45,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // spacer for overlap
            const SliverToBoxAdapter(child: SizedBox(height: 72)),

            // ------------- Favorite Cuisines -------------
            if (p.favoriteCuisines.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: DarkSection(
                    title: 'Favorite Cuisines',
                    child: Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: p.favoriteCuisines
                          .map((label) => CuisineChip(label: label))
                          .toList(),
                    ),
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SpacerWidget(height: 3)),

            // ------------- Moments (grid) -------------
         SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal:  16, vertical:  12, ),
    child: DarkSection(
      title: 'Moments',
      expandedMode: true,
      initiallyExpanded: false,
      child: GridView.builder(
        // physics:  Sc(), // ← Important (so scroll stays with parent)
        padding: EdgeInsets.zero,
        shrinkWrap: true,      
        itemCount: 18,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,          // 2 items per row
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 12/9,        // Makes it square (feel free to adjust)
        ),
        itemBuilder: (_, i) {
          return HeroImageViewer(
    image: app_images.moments,
    tag: "insta_$i",  // unique for each image
  );
          // return ClipRRect(
          //   borderRadius: BorderRadius.circular(2),
          //   child: Image.asset(
          //     app_images.moments,
          //     fit: BoxFit.cover,
          //   ),
          // );
        },
      ),
    ),
  ),
),


            // ------------- Latest From The Instagram (grid) -------------
            SliverToBoxAdapter(
              child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal:  16, vertical:  12, ),

                child: DarkSection(
                  title: 'Latest From The Instagram',
                  child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), 
        padding: EdgeInsets.zero,
        shrinkWrap: true,      
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,          
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 12/9,       
        ),
        itemBuilder: (_, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.asset(
              app_images.moments,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
                ),
              ),
            ),

            // SliverToBoxAdapter(
            //   child:Padding(
            //     padding: const EdgeInsets.fromLTRB(16, 12, 16, 24), 
            //     child: _DarkSection(title: "People You Follow", 
            //     child: Column(
            //       spacing: 10,
            //       children: List.generate(4, (i) => Row(
            //         spacing: 10,
            //         children: [
            //           ClipRRect(borderRadius: BorderRadius.circular(1300),child: Image.asset(app_images.dpIcon, height: 45, ),), 
            //           CustomTextWidget(text: "joshua_l", color: AppColors.background,), 
            //           Container(
            //             color: AppColors.gray500.withValues(alpha: 0.3),
            //             padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            //             child: CustomTextWidget(text: "Following", color: AppColors.background,),
            //           )
            //         ],
            //       )),
            //     ))
            //   ) ,
            // )
          ],
          
        );
      }),
    );
  }

//   bool _shouldCloseOnPullDown(ScrollNotification notification) {
//     if (notification.metrics.axis != Axis.vertical) return false;

//     // When the user is at the top of the sheet and drags downward, close.
//     if (notification is ScrollUpdateNotification) {
//       final delta = notification.scrollDelta ?? 0;
//       final atTop = notification.metrics.pixels <=
//           notification.metrics.minScrollExtent + 0.5;
//       if (notification.dragDetails != null && delta < -8 && atTop) {
//         return true;
//       }
//     } else if (notification is OverscrollNotification) {
//       if (notification.overscroll < 0 &&
//           notification.metrics.pixels <= notification.metrics.minScrollExtent + 0.5) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
}

// ---------- helpers & widgets ----------

class _RoundSvgButton extends StatelessWidget {
  const _RoundSvgButton({
    required this.svgAsset,
    this.onTap,
    this.size = 34,
    super.key,
  });

  final String svgAsset;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Color(0x33000000),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          svgAsset,
          width: size * 0.56,
          height: size * 0.56,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 16,
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: const Color.fromARGB(77, 119, 119, 119),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.white.withValues(alpha:  .08)),
          ),
          child: child,
        ),
      ),
    );
  }
}


// class _DarkSection extends StatelessWidget {
//   const _DarkSection({required this.title, required this.child});
//   final String title;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0x1FFFFFFF), 
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.white.withValues(alpha:  0.06)),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal:  4, vertical:  6, ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             child: CustomTextWidget(text:  title, fontSize: 20, 
//             fontWeight: FontWeight.w800, color: Colors.white),
//           ),
//           const SizedBox(height: 10),
//           child,
//         ],
//       ),
//     );
//   }
// }


/// Round cuisine chip using your cuisine PNGs + white label
class CuisineChip extends StatelessWidget {
  const CuisineChip({required this.label, super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final img = _cuisineToAsset(label);
    return Container(
      height: 76,
      width: 76,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Stack(
        children: [
          ClipOval(child: Image.asset(img, fit: BoxFit.cover, width: 76, height: 76)),
          ClipOval(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x33000000), Color(0x55000000)],
                ),
              ),
            ),
          ),
          Center(
            child: bodyText(
              label,
              size: 12.5,
              color: Colors.white,
              weight: FontWeight.w800,
              align: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _cuisineToAsset(String label) {
    final key = label.trim().toLowerCase();
    if (key.contains('ital')) return app_images.italian_food;
    if (key.contains('mex')) return app_images.mexican_food;
    if (key.contains('asian') || key.contains('sushi')) return app_images.asian_food;
    if (key.contains('amer')) return app_images.american_food;
    return app_images.american_food; // fallback
  }
}
