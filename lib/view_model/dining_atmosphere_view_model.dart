import 'package:get/get.dart';
import '../Models/dining_atmosphere_model.dart';

class DiningAtmosphereViewModel extends GetxController {
  final DiningAtmosphereModel model;
  DiningAtmosphereViewModel(this.model);

  final RxString selected = ''.obs;

  void pick(String value) => selected.value = value;
  bool isSelected(String value) => selected.value == value;

  Future<void> save() async {
    // TODO: persist selected.value if needed
  }
}
