import 'package:flutter/foundation.dart';

@immutable
class HotTrendingPost {
  final String id;
  final String image;        // big hero image
  final String placeName;    // "Burger Palace"
  final bool verified;       // blue tick
  final String caption;      // “the perfect burger…”
  final String followedBy;   // “Followed by …”
  final bool isLiked;

  const HotTrendingPost({
    required this.id,
    required this.image,
    required this.placeName,
    required this.verified,
    required this.caption,
    required this.followedBy,
    this.isLiked = false,
  });

  HotTrendingPost copyWith({bool? isLiked}) =>
      HotTrendingPost(
        id: id,
        image: image,
        placeName: placeName,
        verified: verified,
        caption: caption,
        followedBy: followedBy,
        isLiked: isLiked ?? this.isLiked,
      );
}
