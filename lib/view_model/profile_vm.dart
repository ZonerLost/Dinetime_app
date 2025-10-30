import 'package:get/get.dart';
import '../Constants/app_images.dart';
import '../Models/profile_models.dart';

class ProfileVM extends GetxController {
  final Rx<ProfileModel> state = const ProfileModel(
    name: 'Sarah Chen',
    bio:
    'Food enthusiast, always tracking new flavors and great company. Love exploring hidden gems!',
    avatar: app_images.picture1,
    wishlist: [
      WishlistItem(
        title: 'The Burger Bistro',
        subtitle: 'American Comfort',        // ← add
        image: app_images.burger,
      ),
      WishlistItem(
        title: 'Sakura Sushi Bar',
        subtitle: 'Japanese',                // ← add
        image: app_images.sushi,
      ),
    ],
    instagram: [
      app_images.resturant,
      app_images.pasta,
      app_images.resturant,
      app_images.pasta,
      app_images.resturant,
      app_images.pasta,
    ],
  ).obs;

  // actions
  void editProfile() {
    // TODO: route to edit screen
  }

  void shareProfile() {
    // TODO: share sheet
  }

  void openWishlist(WishlistItem item) {
    // TODO: push details
  }

  void openInstagram(String assetPath) {
    // TODO: open preview
  }
}
