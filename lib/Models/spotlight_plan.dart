import 'package:flutter/foundation.dart';

@immutable
class SpotlightPlan {
  final String title;      // e.g. '1 Spotlight'
  final String priceMain;  // e.g. '$3.99'
  final String priceNote;  // e.g. 'each'
  final String? chip;      // e.g. 'Best Value'
  final String? savings;   // e.g. 'Save 35%'

  const SpotlightPlan({
    required this.title,
    required this.priceMain,
    required this.priceNote,
    this.chip,
    this.savings,
  });
}
