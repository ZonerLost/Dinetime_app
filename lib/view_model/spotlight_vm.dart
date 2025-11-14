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

  final RxSet<String> selectedCuisines = <String>{}.obs;
  
  // Selected price range
  final RxString selectedPriceRange = ''.obs;
  
  // Available cuisine types
  final List<String> cuisineTypes = [
    'American',
    'Chinese',
    'Italian',
    'Japanese',
    'Indian',
    'Mexican',
    'Thai',
    'Korean',
    'Vietnamese',
    'Mediterranean',
    'Middle Eastern',
    'BBQ',
    'Burgers',
    'Pizza',
    'Sushi',
    'Vegan',
    'Vegetarian',
    'Halal',
  ];
  
  // Available price ranges
  final List<String> priceRanges = ['\$', '\$\$', '\$\$\$'];
  

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

  
  // Toggle cuisine selection
  void toggleCuisine(String cuisine) {
    if (selectedCuisines.contains(cuisine)) {
      selectedCuisines.remove(cuisine);
    } else {
      selectedCuisines.add(cuisine);
    }
  }
  
  // Check if cuisine is selected
  bool isCuisineSelected(String cuisine) {
    return selectedCuisines.contains(cuisine);
  }
  
  // Select price range
  void selectPriceRange(String price) {
    if (selectedPriceRange.value == price) {
      selectedPriceRange.value = '';
    } else {
      selectedPriceRange.value = price;
    }
  }

  
  
  // Check if price range is selected
  bool isPriceRangeSelected(String price) {
    return selectedPriceRange.value == price;
  }
  
  // Clear all filters
  void clearAllFilters() {
    selectedCuisines.clear();
    selectedPriceRange.value = '';
  }
  
  // Apply filters
  void applyFilters() {
    // Add your logic here to apply filters
    print('Applied Filters:');
    print('Cuisines: ${selectedCuisines.toList()}');
    print('Price Range: ${selectedPriceRange.value}');
    Get.back();
  }
  
  // Get filter count for badge
  int get filterCount {
    int count = selectedCuisines.length;
    if (selectedPriceRange.value.isNotEmpty) count++;
    return count;
  }

  void openComments() {
    // TODO: route to comments
  }

  void share() {
    // TODO: share sheet
  }
}
