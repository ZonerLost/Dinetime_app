import 'package:get/get.dart';
import '../Models/settings_models.dart';
import '../Screens/privacy_policy_page.dart';
import '../Screens/safety_policy_page.dart';
import '../Screens/terms_conditions_page.dart';

class SettingsVM extends GetxController {
  final state = const SettingsState(
    planName: 'Free plan',
    locationLabel: 'New York, NY',
    languageLabel: 'English',
    perks: [
      PremiumPerk('Instant Match Priority'),
      PremiumPerk('Ad-Free Experience'),
      PremiumPerk('Exclusive Restaurant Deals'),
    ],
  ).obs;

  // toggles
  final showMeOnApp       = true.obs;
  final showDistance      = false.obs;
  final pushNotifications = true.obs;

  // actions
  void openManageSubscription() {}
  void openEditProfile() {}
  void openLocation() {}
  void openPrivacy() {
    Get.to(() => const PrivacyPolicyPage(),
        transition: Transition.cupertino); // pick your vibe
  }
  void openSafety() {
    Get.to(() => const SafetyPolicyPage(), transition: Transition.cupertino);
  }
  void openTerms() {
    Get.to(() => const TermsConditionsPage(), transition: Transition.cupertino);
  }
  void openHelp() {}
  void openLanguage() {}
  void logout() {}
}
