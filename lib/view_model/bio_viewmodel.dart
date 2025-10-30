// lib/view_model/bio_vm.dart
import 'package:get/get.dart';
import '../Models/bio_model.dart';
import '../Models/discover_vm.dart' show DiscoverProfile; // your existing type

class BioVM extends GetxController {
  final Rx<BioModel?> profile = Rx<BioModel?>(null);

  // Populate directly
  void load(BioModel m) => profile.value = m;

  // Convenience: convert from your Discover card
  void fromDiscover(DiscoverProfile d) {
    profile.value = BioModel(
      id: d.id,
      name: d.name,
      age: d.age,
      milesAway: d.milesAway,
      bio: d.bio,
      heroPhoto: d.photo,
      favoriteCuisines: const ['Italian', 'Sushi', 'Burgers'],
      moments: const [
        'assets/images/moment1.png',
        'assets/images/moment2.png',
        'assets/images/moment3.png',
        'assets/images/moment4.png',
      ],
      instagram: const [
        'assets/images/ig1.png','assets/images/ig2.png','assets/images/ig3.png','assets/images/ig4.png',
      ],
      followers: const [
        FollowUser(name: 'jemuel', handle: '@jemuel_', avatar: 'assets/images/avatar1.png'),
        FollowUser(name: 'harmony', handle: '@harmony', avatar: 'assets/images/avatar2.png'),
        FollowUser(name: 'katie', handle: '@katie', avatar: 'assets/images/avatar3.png'),
      ],
    );
  }

  String get nameAge {
    final p = profile.value;
    if (p == null) return '';
    return '${p.name} ${p.age}';
  }

  String get milesLabel {
    final p = profile.value;
    if (p == null) return '';
    final m = p.milesAway;
    return (m % 1 == 0) ? '${m.toStringAsFixed(0)} miles' : '${m.toStringAsFixed(1)} miles';
  }
}
