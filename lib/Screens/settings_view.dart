// lib/Screens/settings_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Constants/app_images.dart';
import '../Constants/app_colors.dart';
import '../view_model/settings_vm.dart';

// ⬇️ import your text helpers
import '../Widgets/custom_text_widget.dart'; // <-- where headingText/bodyText live

class SettingsView extends GetView<SettingsVM> {
  const SettingsView({super.key});

  @override
  SettingsVM get controller => Get.put(SettingsVM(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        titleSpacing: 0,
        title: headingText('Setting', size: 26, color: AppColors.black),
        leading: IconButton(
          icon: SvgPicture.asset(
            app_images.back_icon,
            width: 22,
            height: 22,
            colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          ),
          onPressed: () => Get.back<void>(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                SvgPicture.asset(
                  app_images.ic_settings,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                ClipOval(
                  child: Image.asset(
                    app_images.picture1,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        final s = controller.state.value;
        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(16, 6, 16, safeBottom + 16),
          children: [
            const _Caption('Subscription'),
            const SizedBox(height: 8),

            _PremiumCard(
              perks: s.perks.map((e) => e.title).toList(),
              onManage: controller.openManageSubscription,
            ),

            const SizedBox(height: 14),
            _PlanTile(planName: s.planName),

            const SizedBox(height: 10),
            const _SectionHeader('Account Settings'),

            _ChevronTile(
              icon: app_images.edit_icon,
              label: 'Edit Profile',
              onTap: controller.openEditProfile,
            ),
            _SwitchTile(
              icon: app_images.open_eye,
              label: 'Show me on app',
              value: controller.showMeOnApp.value,
              onChanged: (v) => controller.showMeOnApp.value = v,
            ),

            const _SectionHeader('Discovery Settings'),
            _ValueChevronTile(
              icon: app_images.mark_location,
              label: 'Location',
              value: s.locationLabel,
              onTap: controller.openLocation,
            ),
            _SwitchTile(
              icon: app_images.show_distance,
              label: 'Show Distance',
              value: controller.showDistance.value,
              onChanged: (v) => controller.showDistance.value = v,
            ),

            const _SectionHeader('Notification'),
            _SwitchTile(
              icon: app_images.notification,
              label: 'Push notification',
              value: controller.pushNotifications.value,
              onChanged: (v) => controller.pushNotifications.value = v,
            ),

            const _SectionHeader('Privacy & Security'),
            _ChevronTile(
              icon: app_images.privacy,
              label: 'Privacy',
              onTap: controller.openPrivacy, // no context needed
            ),

            _ChevronTile(icon: app_images.privacy, label: 'Safety & Policy', onTap: controller.openSafety),

            _ChevronTile(icon: app_images.privacy, label: 'Terms & Conditions', onTap: controller.openTerms),

            const _SectionHeader('Language'),
            _ValueChevronTile(
              icon: app_images.language,
              label: 'Language',
              value: s.languageLabel,
              onTap: controller.openLanguage,
            ),

            const _SectionHeader('Help & Support'),
            _ChevronTile(icon: app_images.help, label: 'Help & Support', onTap: controller.openHelp),

            const _SectionHeader('Account'),
            _ChevronTile(
              icon: app_images.logout,
              label: 'Logout',
              onTap: controller.logout,
              isDestructive: true,
            ),
          ],
        );
      }),
    );
  }
}

/// ===== Small helpers & tiles (now using your text helpers) =====

class _Caption extends StatelessWidget {
  const _Caption(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return bodyText(
      text,
      size: 16,
      color: AppColors.gray500,
      weight: FontWeight.w500,
      height: 1.2,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 6),
      child: CustomTextWidget(
       text:  text,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.text_gray,
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  const _PremiumCard({required this.perks, required this.onManage});
  final List<String> perks;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 8)),
        ],
        border: Border.all(color: const Color(0x11000000)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              headingText('Dinetime Premium', size: 20, color: AppColors.black),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8A00),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: headingText('Upgrade', size: 12, color: AppColors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          bodyText(
            'Unlock exclusive features and enhance your dining experience with Dinetime Premium.',
            color: AppColors.text_gray,
            weight: FontWeight.w400,
            height: 1.25,
          ),
          const SizedBox(height: 8),
          ...perks.map((p) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SvgPicture.asset(app_images.orange_check, width: 16, height: 16),
                const SizedBox(width: 8),
                bodyText(p, color: AppColors.text_gray, weight: FontWeight.w400),
              ],
            ),
          )),
          const SizedBox(height: 10),
          SizedBox(
            height: 36,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                elevation: 0,
              ),
              onPressed: onManage,
              child: headingText('Manage Subscription', size: 14, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({required this.planName});
  final String planName;

  @override
  Widget build(BuildContext context) {
    return _TileShell(
      horizontal: 10,
      height: 64, // <- taller like the mock
      left: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Crown
          SvgPicture.asset(app_images.crown, width: 33, height: 34),
          const SizedBox(width: 12),

          // Title + subtitle stacked
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2,), // tiny nudge to match baseline feel
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingText('Free plan', size: 16,  color: AppColors.black),
                  const SizedBox(height: 4),
                  bodyText(
                    'Basic features included',
                    size: 12,
                    color: AppColors.greyshade2,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      right: const SizedBox.shrink(), // nothing on the right in the mock
    );
  }
}


class _ChevronTile extends StatelessWidget {
  const _ChevronTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
    this.fallback,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;
  final IconData? fallback;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: _TileShell(
        left: Row(
          children: [
            _LeadingIcon(path: icon, fallback: fallback, ),
            const SizedBox(width: 10),
            CustomTextWidget(text: label, fontSize: 15, fontWeight: FontWeight.w600,),
          ],
        ),
        right: const Icon(Icons.chevron_right, ),
      ),
    );
  }
}

class _ValueChevronTile extends StatelessWidget {
  const _ValueChevronTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: _TileShell(
        left: Row(
          children: [
            _LeadingIcon(path: icon),
            const SizedBox(width: 10),
            CustomTextWidget(text: label, fontSize: 15, fontWeight: FontWeight.bold,),
          ],
        ),
        right: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            bodyText(value, color: AppColors.text_gray, weight: FontWeight.w400),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return _TileShell(
      left: Row(
        children: [
          _LeadingIcon(path: icon),
          const SizedBox(width: 10),
          CustomTextWidget(text: label, fontSize: 16, fontWeight: FontWeight.bold,),
        ],
      ),
      right: Transform.scale(
        scale: 0.85, // smaller switch
        child: Switch(
          value: value,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

          // ON state → black track, white thumb
          activeTrackColor: AppColors.black,
          activeColor: AppColors.white,

          // OFF state → white track, white thumb
          inactiveTrackColor: AppColors.white,
          inactiveThumbColor: AppColors.black,

          // If your Flutter version supports it, this adds a subtle outline when OFF:
          // trackOutlineColor: WidgetStateProperty.resolveWith(
          //   (states) => states.contains(WidgetState.selected)
          //       ? AppColors.black
          //       : AppColors.gray400,
          // ),
        ),
      ),

    );
  }
}

class _TileShell extends StatelessWidget {
  const _TileShell({
    required this.left,
    required this.right,
    this.horizontal = 3,
    this.height = 52, // <-- new, default keeps other tiles unchanged
  });

  final Widget left;
  final Widget right;
  final double height;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Expanded(child: left),
          right,
        ],
      ),
    );
  }
}


class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({required this.path, this.fallback});
  final String path;
  final IconData? fallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: SvgPicture.asset(
        path,
        width: 20,
        height: 20,
        // No color / colorFilter — show the original asset colors
        placeholderBuilder: (_) => fallback == null
            ? const SizedBox.shrink()
            : Icon(fallback, size: 20),
      ),
    );
  }
}
