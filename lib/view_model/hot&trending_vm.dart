import 'dart:async';

import 'package:get/get.dart';
import '../Models/hot_trending_post.dart';

class HotTrendingVM extends GetxController {
  final int segments = 6;         // ← exactly six bars
  final RxInt currentSegment = 0.obs;
  final RxDouble progress = 0.0.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startAutoProgress();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
  final RxList<HotTrendingPost> posts = <HotTrendingPost>[
    const HotTrendingPost(
      id: 'h1',
      image: 'assets/images/burger.png',
      placeName: 'Burger Palace',
      verified: true,
      caption: 'the perfect burger doesn’t exist… #Foodie #Foodporn',
      followedBy: 'chef.niko and 1 other',
    ),
    const HotTrendingPost(
      id: 'h2',
      image: 'assets/images/burger.png',
      placeName: 'Sora Sushi',
      verified: false,
      caption: 'omakase night unlocked.',
      followedBy: 'mika & 2 others',
    ),
  ].obs;

  final currentIndex = 0.obs;

  HotTrendingPost get current => posts[currentIndex.value];

  void toggleLike() {
    final i = currentIndex.value;
    posts[i] = posts[i].copyWith(isLiked: !posts[i].isLiked);
  }
  void _startAutoProgress() {
    _timer?.cancel();
    // ~4.8s per full bar (0.02 * 120ms * 25 steps ≈ 3s; tweak to taste)
    _timer = Timer.periodic(const Duration(milliseconds: 120), (_) {
      progress.value += 0.04;        // speed; 0.02–0.06 feel good
      if (progress.value >= 1.0) {
        progress.value = 0.0;
        if (currentSegment.value < segments - 1) {
          currentSegment.value++;
        } else {
          currentSegment.value = 0;  // loop
        }
      }
    });
  }

  // optional manual controls (tap-to-skip UI can call these)
  void nextSegment() {
    progress.value = 0.0;
    currentSegment.value =
        (currentSegment.value + 1) % segments;
  }

  void prevSegment() {
    progress.value = 0.0;
    currentSegment.value =
        (currentSegment.value - 1 + segments) % segments;
  }
}

