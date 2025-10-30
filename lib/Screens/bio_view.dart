// lib/Screens/bio_view.dart
import 'dart:ui' show ImageFilter;
import 'package:canada/Constants/responsive.dart';
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
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            p.heroPhoto,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: heroH * 0.42,
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
                    bottom: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: headingText('${p.name} ${p.age}', size: 22, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        GlassPill(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                app_images.show_distance,
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
                  child: _DarkSection(
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

            // ------------- Moments (grid) -------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: _DarkSection(
                  title: 'Moments',
                  child: _PhotoGrid(asset: app_images.moments),
                ),
              ),
            ),

            // ------------- Latest From The Instagram (grid) -------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: _DarkSection(
                  title: 'Latest From The Instagram',
                  child: _PhotoGrid(asset: app_images.moments),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
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
            color: const Color(0x4D1E1E1E),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.white.withOpacity(.08)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class GlassPill extends StatelessWidget {
  const GlassPill({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0x80000000), // 50% black
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Dark rounded section container with a title
class _DarkSection extends StatelessWidget {
  const _DarkSection({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x1FFFFFFF), // subtle dark card
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingText(title, size: 16, color: Colors.white),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

/// 2×2 grid with target tile size ~171x99 (keeps page scrollable)
class _PhotoGrid extends StatelessWidget {
  const _PhotoGrid({required this.asset});
  final String asset;

  static const double _targetW = 171; // px
  static const double _targetH = 99;  // px
  static const double _spacing  = 8;  // grid spacing

  @override
  Widget build(BuildContext context) {
    const crossAxisCount = 2;
    const aspect = _targetW / _targetH; // ≈1.727

    return LayoutBuilder(
      builder: (context, c) {
        // actual tile width given the section width + spacing
        final totalSpacing = _spacing * (crossAxisCount - 1);
        final tileW = (c.maxWidth - totalSpacing) / crossAxisCount;
        // match target ratio => compute height to ~99px when width ~171px
        final tileH = tileW / aspect;

        // total grid height for 2 rows
        final gridH = tileH * 2 + _spacing;

        return SizedBox(
          height: gridH,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: _spacing,
              crossAxisSpacing: _spacing,
              childAspectRatio: aspect,
            ),
            itemBuilder: (_, __) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

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
