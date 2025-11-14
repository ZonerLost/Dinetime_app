import 'package:canada/view_model/hungry_now_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/hungry_active_model.dart';

/// Filter options for the bottom sheet
enum HgGender { any, male, female, other }

class HungryActiveVM extends GetxController {
  HungryActiveVM(this.model);


  final HungryNowVM vmm = Get.find();

  /// Injected data
  final HungryActiveModel model;

  // ───────────────────────────────── UI state
  /// Top-right “Hungry Now” switch
  final RxBool isOn = true.obs;

  /// If you want to keep a “sort by nearest” flag around
  final RxBool sortByNearest = true.obs;

  /// Bottom navigation (optional; use if you wire dt_bottom_nav here)
  final RxInt tabIndex = 0.obs;

  // ───────────────────────────────── Filter state
  /// Selected gender in filter
  final Rx<HgGender> filterGender = HgGender.any.obs;

  /// Distance miles in filter (min..max configurable)
  final RxDouble filterMiles = 2.0.obs;

  /// Bounds for the distance slider
  final double minMiles = 1.0;
  final double maxMiles = 50.0;

  /// Convenience computed list (hook this to the UI if/when you implement real filtering)
  List<HungryActivePerson> get filteredPeople {
   
    // Example (pseudo):
    // return model.people.where((p) => _matchesGender(p) && _withinMiles(p)).toList();
    return model.people;
  }

  // ───────────────────────────────── Actions
  void toggleOn(bool v) => isOn.value = v;

  /// Called by your filter icon. Opens the filter sheet if context is available.
  void toggleSort() {
    final ctx = Get.context;
    if (ctx != null) {
      openFilter(ctx);
    } else {
      sortByNearest.toggle();
    }
  }

    toggleHungryOff(){
      vmm.showLanding();
    }


  /// Open the filter bottom sheet (provide a widget in the view; we just trigger it here)
  void openFilter(BuildContext context, {Widget? sheet}) {
    // If you pass a concrete sheet widget from the view, it'll use that.
    // Otherwise, you can keep calling this from the view with your FilterSheet(vm: this).
    if (sheet == null) return;
    Get.bottomSheet(
      sheet,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.55),
    );
  }

  /// Apply + close
  void applyFilters() {
    // Re-run queries / filter local list here as needed
    update(); // notifies any GetBuilder listeners (Obx watchers already react to Rx changes)
    Get.back(); // close the sheet
  }

  /// Reset to defaults (optional helper for a “Reset” button)
  void resetFilters() {
    filterGender.value = HgGender.any;
    filterMiles.value = 2.0;
  }

  // ───────────────────────────────── Navigation stubs
  void viewChat() {
    // TODO: navigate to chat list
  }

  void message(HungryActivePerson p) {
    // TODO: open chat with [p]
  }

  void openProfile(HungryActivePerson p) {
    // TODO: go to profile preview
  }

  void goSettings() {
    // TODO: navigate to settings screen
  }

// ───────────────────────────────── Optional private helpers for real filtering
// bool _matchesGender(HungryActivePerson p) { ... }
// bool _withinMiles(HungryActivePerson p) { ... }
}

HungryActiveVM createHungryActiveVm() {
  return HungryActiveVM(
    const HungryActiveModel(
      header: const HungryActiveHeader(
        title: 'Now',
        viewChatLabel: 'View Chat',
        avatar: 'assets/images/avatar.png',
      ),
      people: const [
        HungryActivePerson(
          image: 'assets/images/demo1.jpg',
          name: 'Alice',
          age: 24,
          distance: '2 miles away',
          blurb: 'Craving for sushi at monal',
        ),
        HungryActivePerson(
          image: 'assets/images/demo2.jpg',
          name: 'Ben',
          age: 27,
          distance: '1 mile away',
          blurb: 'Burger night? I know a place',
        ),
        HungryActivePerson(
          image: 'assets/images/demo1.jpg',
          name: 'Alice',
          age: 24,
          distance: '2 miles away',
          blurb: 'Craving for sushi at monal',
        ),
      ],
    ),
  );
}
