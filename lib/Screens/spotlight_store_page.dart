import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_colors.dart';
import '../Models/spotlight_plan.dart';
import '../Widgets/custom_text_widget.dart';
import '../Constants/app_images.dart';
import '../view_model/spotlight_store_vm.dart';

class SpotlightStorePage extends StatelessWidget {
  const SpotlightStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpotlightStoreVM>(
      init: SpotlightStoreVM(),
      builder: (vm) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0.5,
            surfaceTintColor: AppColors.white,
            title: headingText('Premium',size: 26),
            centerTitle: false,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                // Header row (flexible to avoid overflow on small screens)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(app_images.whitelucide_sparkles, width: 40, height: 22),
                    const SizedBox(width: 8),
                    Expanded(child: headingText('Spotlight your profile', size: 20)),
                  ],
                ),
                const SizedBox(height: 6),
                bodyText(
                  'Be in the spotlight for 2 hours: appear at the top in your area and get more matches and date invitations instantly.',
                  size: 12,
                  color: AppColors.text_gray,
                  height: 1.5,
                ),
                const SizedBox(height: 16),

                // Plans (with spacing between each)
                Column(
                  children: [
                    for (int i = 0; i < vm.plans.length; i++) ...[
                      _SpotlightPlanCard(
                        plan: vm.plans[i], // <-- removed the unnecessary "!"
                        iconPath: app_images.whitelucide_sparkles,
                        onPressed: () => vm.selectPlan(vm.plans[i]),
                      ),
                      if (i != vm.plans.length - 1) const SizedBox(height: 26),
                    ],
                  ],
                ),

                const SizedBox(height: 16),

                // Premium upsell
                _PremiumCard(
                  title: 'Get Dinetime\npremium for just\n\$15 a month',
                  subtitle: 'Includes 2 free Spotlights every month',
                  buttonText: 'Select Premium',
                  onPressed: vm.selectPremium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ----------------- Widgets -----------------

class _SpotlightPlanCard extends StatelessWidget {
  final SpotlightPlan plan;
  final String iconPath;
  final VoidCallback onPressed;
  const _SpotlightPlanCard({
    required this.plan,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const kCardBg = Color(0xCC000000); // black @ 0.8 (compile-time const)
    final screenW = MediaQuery.sizeOf(context).width;
    final maxCardW = screenW - 32;
    final cardW = maxCardW < 366 ? maxCardW : 366.0;

    return Align(
      alignment: Alignment.center,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: cardW,
            height: 290,
            child: Container(
              decoration: BoxDecoration(
                color: kCardBg,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon round badge
                  Container(
                    width: 66,
                    height: 66,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xCC000000), // 80% black badge
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      iconPath,
                      width: 41,
                      height: 41,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  headingText(plan.title, size: 24, color: Colors.white, align: TextAlign.center),
                  const SizedBox(height: 8),

                  // Price + note
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      bodyText(plan.priceMain, size: 32, color: Colors.white, weight: FontWeight.w700),
                      const SizedBox(width: 6),
                      bodyText(plan.priceNote, size: 16, color: Colors.white70),
                    ],
                  ),

                  if (plan.savings != null) ...[
                    const SizedBox(height: 6),
                    bodyText(plan.savings!, size: 12, color: Colors.white, align: TextAlign.center),
                  ],

                  const SizedBox(height: 15),

                  // Button (solid, radius 4)
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white12,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      onPressed: onPressed,
                      child: bodyText('Select', size: 13, color: Colors.white, weight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Chip (optional)
          if (plan.chip != null)
            Positioned(
              top: -14,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))],
                  ),
                  child: bodyText(plan.chip!, size: 11, color: Colors.white, weight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const _PremiumCard({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const kCardBg = Color(0xCC000000);
    final screenW = MediaQuery.sizeOf(context).width;
    final maxCardW = screenW - 32;
    final cardW = maxCardW < 366 ? maxCardW : 366.0;

    return Align(
      alignment: Alignment.center,
      child: Container(
        width: cardW,
        decoration: BoxDecoration(
          color: kCardBg,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Diamond + text
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 44,
                  height: 44,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // glow
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.35),
                                blurRadius: 28,
                                spreadRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // diamond tile
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          app_images.diamond,
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText(title, size: 24, color: Colors.white),
                      const SizedBox(height: 18),
                      bodyText(subtitle, size: 14, color: Colors.white70, height: 1.5),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Centered CTA
            SizedBox(
              width: 220,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: onPressed,
                child: bodyText('Select Premium', size: 14, color: Colors.black, weight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
