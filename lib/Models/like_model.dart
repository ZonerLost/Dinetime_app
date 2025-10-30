import 'package:flutter/foundation.dart';

@immutable
class LikeProfile {
  final String id;
  final String photo;       // asset path
  final String name;
  final int age;
  final String role;        // e.g., "Food photographer"
  final String city;        // e.g., "NYC"
  final String timeAgo;     // "2h ago"
  final bool liked;

  const LikeProfile({
    required this.id,
    required this.photo,
    required this.name,
    required this.age,
    required this.role,
    required this.city,
    required this.timeAgo,
    this.liked = false,
  });

  LikeProfile copyWith({
    String? id,
    String? photo,
    String? name,
    int? age,
    String? role,
    String? city,
    String? timeAgo,
    bool? liked,
  }) {
    return LikeProfile(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      name: name ?? this.name,
      age: age ?? this.age,
      role: role ?? this.role,
      city: city ?? this.city,
      timeAgo: timeAgo ?? this.timeAgo,
      liked: liked ?? this.liked,
    );
  }
}
