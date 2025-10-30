import 'package:get/get.dart';
import '../Models/hungry_now_model.dart';

class HungryNowVM extends GetxController {
  final HungryNowModel model;
  HungryNowVM(this.model);

  final isOn = false.obs;
  final tabIndex = 0.obs;

  final isActiveNow = false.obs;

  final bullets = const [
    'Instant matches with active users',
    "See who’s hungry nearby",
    'Chat and meet up instantly',
  ];

  void toggle(bool v) => isOn.value = v;

  void onTab(int i) => tabIndex.value = i;

  toggleActiveNow() => isActiveNow.value = !isActiveNow.value;

  void goSettings() {/* TODO: route to settings */}
  void goProfile()  {/* TODO: route to profile  */}
}
