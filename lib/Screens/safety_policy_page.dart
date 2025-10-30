// safety_policy_page.dart
import 'package:flutter/material.dart';
import '../Constants/app_colors.dart';
import '../Widgets/custom_text_widget.dart';

// ---------- Small UI helpers (reuse from privacy page) ----------
class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  const _Section({
    required this.title,
    required this.children,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyText(title, size: 14),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;
  const _Bullet(this.text, {this.padding, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6, height: 6,
            margin: const EdgeInsets.only(top: 8, right: 10),
            decoration: const BoxDecoration(
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(child: bodyText(text, size: 13, height: 1.5)),
        ],
      ),
    );
  }
}

class SafetyPolicyPage extends StatelessWidget {
  const SafetyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: headingText('DINETIME SAFETY &\nPRIVACY', size: 20),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Scrollbar(
          radius: const Radius.circular(8),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                // 1) Your Safety Comes First
                headingText('1. Your Safety Comes First', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'At Dinetime, we’re committed to creating a secure and respectful environment where people can connect to enjoy '
                      'dining experiences and social time. Our goal is safety first: meet smart, meet comfortably, meet joyfully.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8),

                // 2) In-App Safety Features
                headingText('2. In-App Safety Features', size: 18),
                const SizedBox(height: 4),
                _Section(
                  title: 'We’ve built tools to give you control over your safety and privacy:',
                  children: const [
                    _Bullet('Report or Block users: instantly report or block anyone who violates our guidelines.'),
                    _Bullet('Location Controls: choose when and how your location is used.'),
                    _Bullet('Profile Controls: hide or limit profile info visible to people outside your chosen matches.'),
                    _Bullet('Photo & Content Review: optional photo verification and moderation to keep content appropriate.'),
                    _Bullet('Session & Device Controls: manage active sessions and sign out of devices you don’t recognize.'),
                  ],
                ),
                const SizedBox(height: 8),

                // 3) Respect & Community Guidelines
                headingText('3. Respect & Community Guidelines', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'We expect every diner to treat others with respect, both in messages and in person. Harassment, hate speech, '
                      'threats, scams, or illegal activities are not tolerated and may result in removal or law enforcement referral.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8),

                // 4) Privacy Protection
                headingText('4. Privacy Protection', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'We protect your data with encryption in transit and at rest, strict access controls, and continuous monitoring. '
                      'We never sell personal data.\nFor full details, read our Privacy Policy at:',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8),
                // keep simple heading text for links per your preference
                headingText('www.thedinetime.com/privacy', size: 14),
                const SizedBox(height: 8),
                // 5) Tips for Safe Dining
                headingText('5. Tips for Safe Dining', size: 18),
                const SizedBox(height: 8),
                const _Bullet('Meet in public, well-lit locations for your first meetups—restaurants, cafés, or events.'),
                const _Bullet('Share your plan with a trusted friend and consider using location sharing.'),
                const _Bullet('Arrange your own transportation; avoid letting someone you just met drive you.'),
                const _Bullet('Keep personal and financial details private until you’re comfortable and confident.'),
                const _Bullet('If anything feels off, leave early—your safety > social pressure.'),
                const SizedBox(height: 8),

                // 6) Reporting Concerns
                headingText('6. Reporting Concerns', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'See suspicious activity, unsafe behavior, or policy violations? Report it in the app via profile ••• or safety '
                      'tools. If you’re in immediate danger, contact local emergency services first.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8),
                headingText('safety@thedinetime.com', size: 14),
                const SizedBox(height: 6),
                headingText('www.thedinetime.com/safety', size: 14),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
