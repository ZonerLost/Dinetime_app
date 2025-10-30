// Single source of truth for enum + model used everywhere.

enum DiscoverTab { people, hot, spotlight, likes }

class DiscoverProfile {
  final String id;
  final String name;
  final int age;
  final String photo;          // asset or network url
  final double milesAway;
  final List<String> interests; // e.g. ['Dine','Split','Female']
  final String bio;

  const DiscoverProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.photo,
    required this.milesAway,
    required this.interests,
    required this.bio,
  });

  DiscoverProfile copyWith({
    String? id,
    String? name,
    int? age,
    String? photo,
    double? milesAway,
    List<String>? interests,
    String? bio,
  }) {
    return DiscoverProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      photo: photo ?? this.photo,
      milesAway: milesAway ?? this.milesAway,
      interests: interests ?? this.interests,
      bio: bio ?? this.bio,
    );
  }
}
