import 'package:get/get.dart';
import '../Constants/app_images.dart';
import '../Models/like_model.dart';

class LikesVM extends GetxController {
  final RxList<LikeProfile> profiles = <LikeProfile>[
    LikeProfile(
      id: 'l1',
      photo: app_images.picture1,
      name: 'Sarah',
      age: 28,
      role: 'Food photographer',
      city: 'NYC',
      timeAgo: '2h ago',
    ),
    LikeProfile(
      id: 'l2',
      photo: app_images.picture2,
      name: 'Sarah',
      age: 28,
      role: 'Food photographer',
      city: 'NYC',
      timeAgo: '4h ago',
    ),
    LikeProfile(
      id: 'l3',
      photo: app_images.picture2, // just to demo; swap with your own headshot
      name: 'Sarah',
      age: 28,
      role: 'Food photographer',
      city: 'NYC',
      timeAgo: '5h ago',
    ),
  ].obs;

  void toggleLike(String id) {
    final i = profiles.indexWhere((p) => p.id == id);
    if (i == -1) return;
    profiles[i] = profiles[i].copyWith(liked: !profiles[i].liked);
  }

  void removeCard(String id) {
    profiles.removeWhere((p) => p.id == id);
  }
}
