import 'package:flutter/foundation.dart';

class HungryActiveHeader {
  final String title;           // “Now”
  final String viewChatLabel;   // “View Chat”
  final String avatar;          // local asset path (png/svg)
  const HungryActiveHeader({
    required this.title,
    required this.viewChatLabel,
    required this.avatar,
  });
}

class HungryActivePerson {
  final String image;     // card main image
  final String name;      // “Alice”
  final int age;          // 24
  final String distance;  // “2 miles away”
  final String blurb;     // “Craving for sushi at monal”
  const HungryActivePerson({
    required this.image,
    required this.name,
    required this.age,
    required this.distance,
    required this.blurb,
  });
}

@immutable
class HungryActiveModel {
  final HungryActiveHeader header;
  final List<HungryActivePerson> people;
  const HungryActiveModel({required this.header, required this.people});
}
