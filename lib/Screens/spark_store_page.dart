import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Constants/app_colors.dart';
import '../Widgets/custom_text_widget.dart';
import '../Constants/app_images.dart'; // wherever your app_images class lives

class SparkStorePage extends StatelessWidget {
  const SparkStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        surfaceTintColor: AppColors.white,
        title: headingText('Premium', size: 22),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            // Title row
            Row(
              children: [
                SvgPicture.asset(app_images.black_thunder, width: 25, height: 30),
                const SizedBox(width: 6),
                headingText('Spark Someone', size: 20),
              ],
            ),
            const SizedBox(height: 6),
            bodyText(
              'Be seen first. Send a Spark to highlight your profile and move to the top of their feed.',
              size: 13,
              color: AppColors.text_gray,
              height: 1.5,
            ),
            const SizedBox(height: 16),

            // Packs
            // Packs (with spacing between each)
            Column(
              children: [
                _SparkPlanCard(
                  iconPath: app_images.white_thunder,
                  title: '1 Spark',
                  priceMain: r'$1.99',
                  priceNote: 'each',
                  buttonText: 'Select',
                  onPressed: () {},
                ),
                const SizedBox(height: 26), // <-- spacing between cards

                _SparkPlanCard(
                  iconPath: app_images.white_thunder,
                  title: '10 Sparks',
                  priceMain: r'$2.20',
                  priceNote: 'each',
                  chipText: 'Best Value',
                  onPressed: () {},
                ),
                const SizedBox(height: 26), // <-- spacing between cards

                _SparkPlanCard(
                  iconPath: app_images.white_thunder,
                  title: '5 Sparks',
                  priceMain: r'$1.50',
                  priceNote: 'each',
                  chipText: 'Most Popular',
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Premium upsell
            _PremiumCard(
              title: 'Get Dinetime premium for just\n\$15 a month',
              subtitle: 'Includes 15 free Sparks every month',
              buttonText: 'Select Premium',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- Widgets -----------------


class _SparkPlanCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String priceMain;     // e.g. "$2.20"
  final String priceNote;     // e.g. "/each"
  final String? chipText;     // e.g. "Best Value"
  final String? savingsText;  // e.g. "Save 40%"
  final String buttonText;
  final VoidCallback onPressed;

  const _SparkPlanCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.priceMain,
    required this.priceNote,
    required this.onPressed,
    this.chipText,
    this.savingsText,
    this.buttonText = 'Select',
  });

  @override
  Widget build(BuildContext context) {
    // 80% black background (#000000CC)
    final Color kCardBg = Colors.black.withOpacity(0.8);


    final screenW = MediaQuery.sizeOf(context).width;
    final maxCardW = screenW - 32; // respect outer page padding
    final cardW = maxCardW < 366 ? maxCardW : 366.0;

    return Align(
      alignment: Alignment.center,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // CARD
          SizedBox(
            width: cardW,
            height: 270, // ~270 as requested
            child: Container(
              decoration: BoxDecoration(
                color: kCardBg,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // circular icon badge
                Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.8),
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

                  // title
                  headingText(
                    title,
                    size: 24,
                    color: Colors.white,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // price + /each (like screenshot)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      bodyText(
                        priceMain,
                        size: 32, // a bit larger for emphasis like mock
                        color: Colors.white,
                        weight: FontWeight.w700,
                      ),
                      const SizedBox(width: 6),
                      bodyText(
                        priceNote,
                        size: 16,
                        color: Colors.white70,
                      ),
                    ],
                  ),

                  if (savingsText != null) ...[
                    const SizedBox(height: 6),
                    bodyText(
                      savingsText!,
                      size: 12,
                      color: Colors.white70,
                      align: TextAlign.center,
                    ),
                  ],

                  SizedBox(height: 15,),

                  // select button (muted gray like mock)
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white12, // same soft gray/white overlay
                        elevation: 0, // flat like your mock
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4), // radius 4
                        ),
                      ),
                      onPressed: onPressed,
                      child: bodyText(
                        buttonText,
                        size: 13,
                        color: Colors.white,
                        weight: FontWeight.w600,
                        align: TextAlign.center,
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),

          // CHIP (pills sit above the card like the image)
          if (chipText != null)
            Positioned(
              top: -14, // floats above the rounded top edge
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black, // dark pill
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                  child: bodyText(
                    chipText!,
                    size: 11,
                    color: Colors.white,
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  final String title;       // 'Get Dinetime\npremium for just\n$15 a month'
  final String subtitle;    // 'Includes 3 free Sparks every month'
  final String buttonText;  // 'Select Premium'
  final VoidCallback onPressed;

  const _PremiumCard({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const kCardBg = Color(0xCC000000); // 80% black

    final screenW = MediaQuery.sizeOf(context).width;
    final maxCardW = screenW - 32; // match page padding
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
            // === Top row: diamond on the left, text on the right ===
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Diamond with glow (small and inset like the comp)
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
                      // diamond tile (do NOT make huge)
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
                          width: 1016,
                          height: 1016,
                          colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Headline + subtitle (left aligned)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText(
                        title,
                        size: 24,
                        color: Colors.white,
                        align: TextAlign.start,
                      ),
                      const SizedBox(height: 18),
                      bodyText(
                        subtitle,
                        size: 14,
                        color: Colors.white70,
                        height: 1.5,
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // === Centered white button ===
            SizedBox(
              width: 220,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onPressed,
                child: bodyText(
                  buttonText,
                  size: 14,
                  color: Colors.black,
                  weight: FontWeight.w700,
                  align: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

