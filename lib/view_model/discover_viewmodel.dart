// discover_viewmodel.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/discover_vm.dart';
import '../Models/spotlight_model.dart';
import '../Models/filter_model.dart';      // ← your FilterData + HgGender
import '../Screens/spark_store_page.dart';
import '../Screens/spotlight_store_page.dart';
import '../Widgets/filter_sheet2.dart' hide FilterData;
import 'bio_viewmodel.dart';    // ← the decoupled sheet
enum DiscoverTab { people, hotTrending, spotlight, likes }
class DiscoverVM extends GetxController {
  final tab = DiscoverTab.people.obs;

  // current “discover” filters (local to this screen)
  final Rx<FilterData> filters = const FilterData().obs;
  final RxBool showInfo = false.obs;

  void setTab(DiscoverTab t) => tab.value = t;

  final RxString currentSelectedSpotlight = "".obs;
  void selectSpotlight(String spot) => currentSelectedSpotlight.value = spot;

  @override
  void onInit() {
    currentSelectedSpotlight.value = listSpotLight.first.title;
    super.onInit();
  }

  // profile data …
  final profile = const DiscoverProfile(
    id: 'p1',
    name: 'Alice',
    age: 24,
    photo: 'assets/images/Image (4).png',
    milesAway: 2.0,
    interests: ['Dine', 'Split', 'Female'],
    bio: 'Looking for a fun dinner spot tonight!',
  ).obs;

  String get nameAge => '${profile.value.name} ${profile.value.age}';
  double get milesAway => profile.value.milesAway;
  List<String> get inFor => profile.value.interests;
  String get bio => profile.value.bio;
  String get photo => profile.value.photo;

  // actions (stub)
  void dislike() {}
  void like() {}
  void superLike() {
    // Navigate to the store
    Get.to(() => const SparkStorePage(), transition: Transition.cupertino);
  }
  void spark(){
    Get.to(() => const SpotlightStorePage(), transition: Transition.cupertino);
  }
  void openMore() {}

  void openInfo(DiscoverProfile d) {
    final bio = Get.put(BioVM(), permanent: false);
    bio.fromDiscover(d);
    showInfo.value = true;
  }

  void closeInfo() {
    showInfo.value = false;
    Future.delayed(const Duration(milliseconds: 320), () {
      if (!showInfo.value && Get.isRegistered<BioVM>()) {
        Get.delete<BioVM>();
      }
    });
  }

  // ⬇️ Launch the reusable filter sheet
  Future<void> openFilter() async {
    final result = await showModalBottomSheet<FilterData>(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => FilterSheet2(
        initial: filters.value,
        onChanged: (live) => filters.value = live,   // optional live preview
        onApply: (applied) => filters.value = applied,
      ),
    );

    if (result != null) {
      filters.value = result;
    }

    // TODO: use filters.value.gender / filters.value.miles to refresh your content
  }


}
