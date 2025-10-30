import 'package:get/get.dart';
import '../Models/SpotLightModel2.dart';
import '../Constants/app_images.dart';

enum SpotlightFilter { latestInArea, peopleYouFollow }

class SpotlightVM extends GetxController {
  // data
  final RxList<SpotlightPost> posts = <SpotlightPost>[
    SpotlightPost(
      id: 's1',
      image: app_images.burger, // your burger hero
      placeName: 'Burger Palace',
      caption: "the perfect burger doesn’t exist…#foodie #foodporn",
      followedBy: 'chef-mike and 1 other',
      verified: true,
      likes: 115000,
      comments: 60000,
      shares: 23000,
    ),
  ].obs;

  final currentIndex = 0.obs;
  SpotlightPost get current => posts[currentIndex.value];

  // ui state
  final Rx<SpotlightFilter> filter = SpotlightFilter.latestInArea.obs;

  void setFilter(SpotlightFilter f) => filter.value = f;

  void toggleBookmark() {
    final i = currentIndex.value;
    posts[i] = posts[i].copyWith(isBookmarked: !posts[i].isBookmarked);
  }

  void like() {
    final i = currentIndex.value;
    posts[i] = posts[i].copyWith(likes: posts[i].likes + 1);
  }

  void openComments() {
    // TODO: route to comments
  }

  void share() {
    // TODO: share sheet
  }
}
