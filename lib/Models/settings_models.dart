import 'package:flutter/foundation.dart';

@immutable
class PremiumPerk {
  final String title;
  const PremiumPerk(this.title);
}

@immutable
class SettingsState {
  final String planName;           // e.g., "Free plan"
  final String locationLabel;      // e.g., "New York, NY"
  final String languageLabel;      // e.g., "English"
  final List<PremiumPerk> perks;

  const SettingsState({
    required this.planName,
    required this.locationLabel,
    required this.languageLabel,
    required this.perks,
  });

  SettingsState copyWith({
    String? planName,
    String? locationLabel,
    String? languageLabel,
    List<PremiumPerk>? perks,
  }) {
    return SettingsState(
      planName: planName ?? this.planName,
      locationLabel: locationLabel ?? this.locationLabel,
      languageLabel: languageLabel ?? this.languageLabel,
      perks: perks ?? this.perks,
    );
  }
}
