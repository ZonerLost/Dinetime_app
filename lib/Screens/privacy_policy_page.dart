import 'package:flutter/material.dart';

import '../Constants/app_colors.dart';
import '../Widgets/custom_text_widget.dart';

// ---------- Small UI helpers ----------
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingText(title, size: 16),
        const SizedBox(height: 4),
        ...children,
      ],
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
          // bullet dot
          Container(
            width: 6,
            height: 6,
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

// Simple, local read-only text field for now
InputDecoration _readonlyDecoration(String hint) {
  OutlineInputBorder _b(Color c) =>
      OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: c, width: 1));
  return InputDecoration(
    hintText: hint,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    filled: true,
    fillColor: const Color(0xFFF0F0F0),
    border: _b(AppColors.greyshade3),
    enabledBorder: _b(AppColors.greyshade3),
    focusedBorder: _b(AppColors.black),
  );
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: headingText('DINETIME PRIVACY\n POLICY', size: 20),
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
                // 1) Overview
                headingText('1. Overview', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'At Dinetime, we value your trust and privacy. This Privacy Policy explains how we collect, use, and protect your personal information when you use our app, website, or related services (collectively, the “Platform”). By using Dinetime, you agree to this Policy.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8), // <-- added after Section 1

                // 2) Information We Collect
                headingText('2. Information We Collect', size: 18),
                const SizedBox(height: 10),
                _Section(
                  title: 'a. Information You Provide',
                  children: const [
                    _Bullet('Profile details (name, photo, bio, preferences)'),
                    _Bullet('Contact information (email, phone number)'),
                    _Bullet('Payment details (if you purchase premium features)'),
                    _Bullet('Restaurant preferences, dining interests, and match selections'),
                  ],
                ),
                _Section(
                  title: 'b. Automatically Collected Data',
                  children: const [
                    _Bullet('Device and app usage data'),
                    _Bullet('Location (when you enable location sharing)'),
                    _Bullet('IP address, device identifiers, and analytics data for app performance'),
                  ],
                ),
                _Section(
                  title: 'c. Third-Party Integrations',
                  children: const [
                    _Bullet('We may collect data through integrated services such as:'),
                    _Bullet('OpenTable for reservations'),
                    _Bullet('Meta / Instagram API for social sharing or login'),
                  ],
                ),
                const SizedBox(height: 8), // <-- added after Section 2

                // 3) How We Use Your Information
                headingText('3. How We Use Your Information', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'We use your data to personalize your experience, enable bookings and chats, improve app performance, send updates, and analyze engagement.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8), // <-- added after Section 3

                // 4) Sharing of Information
                headingText('4. Sharing of Information', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'We do not sell your personal data. We only share limited information with restaurants or event hosts, service providers (hosting, analytics), or legal authorities if required by law.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8), // <-- added after Section 4

                // 5) Your Choices
                headingText('5. Your Choices', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'You can update or delete your profile anytime, control who sees your activity, disable location sharing, and opt out of promotional emails. Deleting your account removes your profile, matches, and data from our servers (subject to legal retention obligations).',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8),
                // 6) Data Security
                headingText('6. Data Security', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'We use advanced encryption, secure servers, and regular security audits to protect your information from unauthorized access or misuse.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8),
                // 7) International Use
                headingText('7. International Use', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'As a global platform, your information may be stored or processed in different countries. We ensure appropriate safeguards under applicable data protection laws.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8),
                // 8) Updates to This Policy
                headingText('8. Updates to This Policy', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'We may update this Privacy Policy from time to time. The latest version will always be available in the app and on our website.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 8),
                // 9) Contact Us
                headingText('9. Contact Us', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'If you have questions about privacy or data use, contact us at:',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 10),

                // Replaced GestureDetectors with read-only TextFormFields
                // Replaced TextFormFields with simple headings
                headingText('privacy@thedinetime.com', size: 14),
                const SizedBox(height: 6),
                headingText('www.thedinetime.com', size: 14),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
