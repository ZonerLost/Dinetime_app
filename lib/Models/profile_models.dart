import 'package:flutter/foundation.dart';

@immutable
class ProfileModel {
  final String name;
  final String bio;
  final String avatar;          // asset path
  final List<WishlistItem> wishlist;
  final List<String> instagram; // asset paths

  const ProfileModel({
    required this.name,
    required this.bio,
    required this.avatar,
    required this.wishlist,
    required this.instagram,
  });

  ProfileModel copyWith({
    String? name,
    String? bio,
    String? avatar,
    List<WishlistItem>? wishlist,
    List<String>? instagram,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      avatar: avatar ?? this.avatar,
      wishlist: wishlist ?? this.wishlist,
      instagram: instagram ?? this.instagram,
    );
  }
}

@immutable
class WishlistItem {
  final String title;
  final String subtitle;   // ← add this
  final String image;

  const WishlistItem({
    required this.title,
    required this.subtitle, // ← add this
    required this.image,
  });
}
