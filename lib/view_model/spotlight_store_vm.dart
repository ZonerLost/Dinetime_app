import 'package:get/get.dart';
import '../Models/spotlight_plan.dart';


class SpotlightStoreVM extends GetxController {
  final plans = <SpotlightPlan>[
    const SpotlightPlan(
      title: '1 Spotlight',
      priceMain: r'$3.99',
      priceNote: 'each',
    ),
    const SpotlightPlan(
      title: '10 Spotlights',
      priceMain: r'$2.50',
      priceNote: 'each',
      chip: 'Best Value',
      savings: 'Save 35%',
    ),
    const SpotlightPlan(
      title: '5 Spotlights',
      priceMain: r'$3.00',
      priceNote: 'each',
      chip: 'Most Popular',
      savings: 'Save 25%',
    ),
  ].obs;

  final isLoading = false.obs;

  void selectPlan(SpotlightPlan plan) {
    // TODO: hook to purchase flow
    // debugPrint('Selected: ${plan.title}');
  }

  void selectPremium() {
    // TODO: premium purchase logic
  }
}
