// lib/Models/bio_model.dart
class BioModel {
  final String id;
  final String name;
  final int age;
  final double milesAway;
  final String bio;
  final String heroPhoto;

  final List<String> favoriteCuisines; // labels/pills
  final List<String> moments;          // image asset paths
  final List<String> instagram;        // image asset paths

  final List<FollowUser> followers;    // "People You Follow"

  const BioModel({
    required this.id,
    required this.name,
    required this.age,
    required this.milesAway,
    required this.bio,
    required this.heroPhoto,
    this.favoriteCuisines = const [],
    this.moments = const [],
    this.instagram = const [],
    this.followers = const [],
  });

  BioModel copyWith({
    String? id,
    String? name,
    int? age,
    double? milesAway,
    String? bio,
    String? heroPhoto,
    List<String>? favoriteCuisines,
    List<String>? moments,
    List<String>? instagram,
    List<FollowUser>? followers,
  }) {
    return BioModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      milesAway: milesAway ?? this.milesAway,
      bio: bio ?? this.bio,
      heroPhoto: heroPhoto ?? this.heroPhoto,
      favoriteCuisines: favoriteCuisines ?? this.favoriteCuisines,
      moments: moments ?? this.moments,
      instagram: instagram ?? this.instagram,
      followers: followers ?? this.followers,
    );
  }
}

class FollowUser {
  final String name;
  final String handle;
  final String avatar; // image path
  const FollowUser({required this.name, required this.handle, required this.avatar});
}
