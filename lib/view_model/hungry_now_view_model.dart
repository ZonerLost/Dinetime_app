import 'package:get/get.dart';
import '../Models/hungry_now_model.dart';

enum HungrySubPage { landing, activateNow, hungryActive }

class HungryNowVM extends GetxController {
  final HungryNowModel model;
  HungryNowVM(this.model);

  final isOn = false.obs;
  final tabIndex = 0.obs;
  final subPage = HungrySubPage.landing.obs;

  final bullets = const [
    'Instant matches with active users',
    "See who’s hungry nearby",
    'Chat and meet up instantly',
  ];

  void toggle(bool v) {
    isOn.value = v;
    subPage.value = v ? HungrySubPage.activateNow : HungrySubPage.landing;
  }

  void onTab(int i) => tabIndex.value = i;

  void showLanding() {
    isOn.value = false;
    subPage.value = HungrySubPage.landing;
  }

  void showActivateNow() {
    isOn.value = true;
    subPage.value = HungrySubPage.activateNow;
  }

  void showHungryActive() {
    isOn.value = true;
    subPage.value = HungrySubPage.hungryActive;
  }

  void goSettings() {/* TODO: route to settings */}
  void goProfile()  {/* TODO: route to profile  */}
}
