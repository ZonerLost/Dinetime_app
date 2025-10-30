import 'package:get/get.dart';
import '../Models/splash_model.dart';
import '../Routes/app_routes.dart';


class SplashViewModel extends GetxController {
  final SplashModel _model;
  SplashViewModel(this._model);

  @override
  void onReady() {
    super.onReady();
    Future.delayed(_model.delay, () {
      Get.offAllNamed(AppRoutes.signUp);
    });
  }
}
