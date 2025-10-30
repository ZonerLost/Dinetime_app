import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../Models/setup_profile_model.dart' as m;
import '../Routes/app_routes.dart';

class SetupProfileViewModel extends GetxController {
  final m.SetupProfileModel model;
  SetupProfileViewModel(this.model);

  // Photos
  final RxList<XFile?> photos = <XFile?>[].obs;

  // Smart Photos
  final smartPhotos = false.obs;
  void toggleSmartPhotos(bool v) => smartPhotos.value = v;

  // Tabs
  final RxInt tabIndex = 0.obs;
  void setTab(int i) {
    if (tabIndex.value != i) tabIndex.value = i;
  }

  // Age + Gender
  final RxnInt age = RxnInt();
  final Rxn<m.Gender> selectedGender = Rxn<m.Gender>();
  void setGender(m.Gender? g) => selectedGender.value = g;

  // Selectors
  final List<String> cuisines = const [
    'Italian','Mexican','Japanese','Thai','Indian','Chinese',
    'Korean','American','Mediterranean','Vietnamese'
  ];
  final List<String> hobbies = const [
    'Cooking','Dancing','Hiking','Traveling','Reading','Painting',
    'Music','Gym','Yoga','Art','Gaming','Writing'
  ];

  // Rx sets (no manual refresh needed for add/remove)
  final RxSet<String> selectedCuisines = <String>{}.obs;
  final RxSet<String> selectedHobbies = <String>{}.obs;

  // Simple validation flag
  final isValid = true.obs;

  // Controllers
  late final TextEditingController aboutCtrl;
  late final TextEditingController foodCtrl;

  final int aboutMaxChars = 160;
  final RxnString instagramUsername = RxnString();

  final _picker = ImagePicker();

  List<int> get ages => List<int>.generate(83, (i) => i + 18); // 18..100

  @override
  void onInit() {
    super.onInit();
    photos.assignAll(List<XFile?>.filled(model.maxPhotos, null));

    aboutCtrl = TextEditingController();
    foodCtrl = TextEditingController();

    aboutCtrl.addListener(revalidate);
    ever<int?>(age, (_) => revalidate());
    ever<m.Gender?>(selectedGender, (_) => revalidate());
    ever<Set<String>>(selectedCuisines, (_) => revalidate());
    ever<Set<String>>(selectedHobbies, (_) => revalidate());
  }

  void toggleCuisine(String c) {
    if (selectedCuisines.contains(c)) {
      selectedCuisines.remove(c);
    } else {
      selectedCuisines.add(c);
    }
  }

  void toggleHobby(String h) {
    if (selectedHobbies.contains(h)) {
      selectedHobbies.remove(h);
    } else {
      selectedHobbies.add(h);
    }
  }

  void revalidate() => isValid.value = true;

  Future<void> pickPhoto(int index) async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (file == null) return;
    if (index >= 0 && index < photos.length) {
      photos[index] = file; // RxList will notify
    }
  }

  Future<void> linkInstagram() async {
    instagramUsername.value = 'your_username';
  }

  String labelOf(m.Gender g) {
    switch (g) {
      case m.Gender.male: return 'Male';
      case m.Gender.female: return 'Female';
      case m.Gender.nonBinary: return 'Non-binary';
      case m.Gender.preferNotToSay: return 'Prefer not to say';
      case m.Gender.Others: return 'Others';
    }
  }

  void saveAndGoNext() {
    Get.toNamed(AppRoutes.foodInterest);
  }

  @override
  void onClose() {
    aboutCtrl.dispose();
    foodCtrl.dispose();
    super.onClose();
  }
}
