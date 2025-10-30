import 'package:flutter/foundation.dart';

@immutable
class UpcomingReservation {
  final String id;
  final String restaurantName;
  final String image;           // asset path
  final String address;         // line 2 under name
  final String date;            // e.g. "Oct 18, 2025"
  final String time;            // e.g. "7:30 PM"
  final int guests;             // "4 Guests"
  final String status;          // "Confirmed" / "Pending"
  final bool isVip;             // tiny "VIP" pill in the image

  const UpcomingReservation({
    required this.id,
    required this.restaurantName,
    required this.image,
    required this.address,
    required this.date,
    required this.time,
    required this.guests,
    this.status = 'Confirmed',
    this.isVip = false,
  });
}

@immutable
class PastReservation {
  final String id;
  final String restaurantName;
  final String image;   // small avatar asset
  final String date;    // "Oct 15, 2025"
  final int guests;     // 3, 6, etc.

  const PastReservation({
    required this.id,
    required this.restaurantName,
    required this.image,
    required this.date,
    required this.guests,
  });
}
