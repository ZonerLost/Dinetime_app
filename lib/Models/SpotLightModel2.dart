import 'package:flutter/foundation.dart';

@immutable
class SpotlightPost {
  final String id;
  final String image;
  final String placeName;
  final String caption;
  final String followedBy;
  final bool verified;
  final bool isBookmarked;
  final int likes;
  final int comments;   // using your white_chat as comment count
  final int shares;     // using your arrow as share/forward

  const SpotlightPost({
    required this.id,
    required this.image,
    required this.placeName,
    required this.caption,
    required this.followedBy,
    this.verified = false,
    this.isBookmarked = false,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
  });

  SpotlightPost copyWith({
    String? id,
    String? image,
    String? placeName,
    String? caption,
    String? followedBy,
    bool? verified,
    bool? isBookmarked,
    int? likes,
    int? comments,
    int? shares,
  }) {
    return SpotlightPost(
      id: id ?? this.id,
      image: image ?? this.image,
      placeName: placeName ?? this.placeName,
      caption: caption ?? this.caption,
      followedBy: followedBy ?? this.followedBy,
      verified: verified ?? this.verified,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
    );
  }
}
