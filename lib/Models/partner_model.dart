// lib/Models/partner_model.dart
import 'package:flutter/material.dart';

class PartnerCard {
  final IconData icon;     // ← IconData now
  final String title;
  final String subtitle;
  const PartnerCard({required this.icon, required this.title, required this.subtitle});
}

class PartnerWithDineTimeModel {
  final List<PartnerCard> cards;
  const PartnerWithDineTimeModel({required this.cards});

  factory PartnerWithDineTimeModel.builtins() {
    return PartnerWithDineTimeModel(cards: [
      PartnerCard(
        icon: Icons.public, // Expand reach
        title: 'EXPAND REACH',
        subtitle: 'Connect with food enthusiasts actively searching for dining experiences.',
      ),
      PartnerCard(
        icon: Icons.trending_up, // Increase revenue
        title: 'INCREASE REVENUE',
        subtitle: 'Fill tables during off-peak hours and maximize earning potential.',
      ),
      PartnerCard(
        icon: Icons.event_available, // Smart bookings
        title: 'SMART BOOKINGS',
        subtitle: 'Streamline reservations with intelligent management tools.',
      ),
      PartnerCard(
        icon: Icons.workspace_premium, // Premium placement
        title: 'PREMIUM PLACEMENT',
        subtitle: 'Showcase your restaurant with featured listings.',
      ),
    ]);
  }
}
