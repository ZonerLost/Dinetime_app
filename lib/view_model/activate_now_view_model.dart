import 'package:get/get.dart';
import '../Models/activate_now_model.dart';

class ActivateNowVM extends GetxController {
  final ActivateNowModel model;
  ActivateNowVM(this.model);

  void cancel() => Get.back();
  void activate() {
    // TODO: call API / update state
    Get.back(); // for now, just pop back
  }
}
