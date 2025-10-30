// terms_conditions_page.dart
import 'package:flutter/material.dart';
import '../Constants/app_colors.dart';
import '../Widgets/custom_text_widget.dart';

// ---------- Small UI helpers (same pattern as other pages) ----------
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
          headingText(title, size: 18),
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

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: headingText('Terms & Conditions', size: 26),
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
                // Header line
                bodyText(
                  'DineTime – Terms & Conditions\nEffective Date: [Insert Date] | Last Updated: [Insert Date]',
                  size: 16,
                  height: 1.6,
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 24),

                // Overview
                headingText('Overview', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'DineTime (“we,” “our,” “us”) provides a social dining platform where users can discover restaurants, connect socially, and make reservations through partner integrations such as OpenTable and Meta/Instagram APIs. These Terms govern your use of the DineTime App, website, and related services.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Eligibility
                headingText('Eligibility', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'You must be at least 18 years old, legally capable of entering into binding contracts, and using DineTime for lawful, personal, non-commercial purposes. We reserve the right to suspend or terminate any account violating these conditions.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Account Creation and Security
                headingText('Account Creation and Security', size: 18),
                const SizedBox(height: 8),
                const _Bullet('Users must provide accurate, up-to-date information and are responsible for maintaining their account security.'),
                const _Bullet('DineTime is not responsible for unauthorized access or misuse of credentials.'),
                const SizedBox(height: 24),

                // User Conduct
                headingText('User Conduct', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'You agree not to engage in harassment, abuse, false or misleading content, discrimination, or unlawful activity. Misuse of DineTime features or APIs may result in immediate suspension or termination of access.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Subscriptions and Payments
                headingText('Subscriptions and Payments', size: 18),
                const SizedBox(height: 8),
                const _Bullet('Premium features such as Spark Boosts, Hungry Now, and Premium Memberships may require payment.'),
                const _Bullet('All payments are processed through Apple, Google, or approved payment partners.'),
                const _Bullet('Payments are non-refundable except as required by law.'),
                const _Bullet('Subscriptions auto-renew unless cancelled at least 24 hours before renewal.'),
                const SizedBox(height: 24),

                // API Integrations and Third-Party Services
                headingText('API Integrations and Third-Party Services', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'DineTime integrates with third-party APIs to enhance user experience. By using these features, you also agree to the respective platform’s terms and privacy policies.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 10),
                _Section(
                  title: '(a) OpenTable API',
                  children: const [
                    _Bullet('Restaurant discovery and reservations are powered by OpenTable’s API.'),
                    _Bullet('DineTime does not control restaurant operations, pricing, or booking policies.'),
                    _Bullet('All reservations are governed by OpenTable’s own terms and privacy policies.'),
                  ],
                ),
                _Section(
                  title: '(b) Meta / Instagram API',
                  children: const [
                    _Bullet('Users may link their Instagram accounts to display photos, bios, or social handles.'),
                    _Bullet('DineTime uses Meta APIs under Meta’s Platform Terms and Developer Policies.'),
                    _Bullet('DineTime only accesses minimal public data (e.g., username, profile photo) and never posts without explicit user consent.'),
                    _Bullet('Permissions can be revoked anytime from Instagram settings.'),
                  ],
                ),
                _Section(
                  title: '(c) Other APIs',
                  children: const [
                    _Bullet('DineTime may integrate with additional APIs such as Resy, Yelp, or Google Maps.'),
                    _Bullet('These are governed by their own usage terms and privacy standards.'),
                  ],
                ),
                const SizedBox(height: 24),

                // Content Ownership
                headingText('Content Ownership', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'Users retain rights to their content but grant DineTime a worldwide, royalty-free license to use, reproduce, and display it for app functionality and marketing. DineTime owns all trademarks, designs, and software code of the platform.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Privacy & Data Use
                headingText('Privacy & Data Use', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'DineTime handles data in accordance with its Privacy Policy at www.thedinetime.com/privacy. Data collected may include profile details, preferences, and API-linked info. DineTime never sells personal data; anonymized data may be used for analytics.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Safety Disclaimer
                headingText('Safety Disclaimer', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'DineTime does not perform background checks. Users should meet others in public and act responsibly. DineTime is not liable for the actions of users on or off the platform.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Termination
                headingText('Termination', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'DineTime may suspend or delete accounts for violations, unsafe behavior, or inactivity. Users can delete their accounts anytime through app settings.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Limitation of Liability
                headingText('Limitation of Liability', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'DineTime is provided “as is.” We do not guarantee continuous availability or accuracy. DineTime is not liable for indirect or consequential damages, data loss, or third-party service issues.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Modifications to the Terms
                headingText('Modifications to the Terms', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'We may update these Terms periodically. Revised Terms take effect immediately upon posting in-app or online. Continued use implies acceptance.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Governing Law
                headingText('Governing Law', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'These Terms are governed by the laws of Delaware, USA (or Dubai, UAE, if applicable). Disputes will be resolved exclusively in the competent courts of that jurisdiction.',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 24),

                // Contact Us
                headingText('Contact Us', size: 18),
                const SizedBox(height: 8),
                bodyText(
                  'For questions or concerns about these Terms or integrations, contact us at:',
                  size: 13,
                  height: 1.6,
                ),
                const SizedBox(height: 6),
                headingText('support@thedinetime.com', size: 16),
                const SizedBox(height: 4),
                headingText('www.thedinetime.com', size: 16),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
