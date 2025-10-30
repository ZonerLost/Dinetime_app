import 'package:canada/Controllers/nav_bar_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AppBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(NavbarController());
  }
}