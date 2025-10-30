import 'package:get/get.dart';

class NavbarController extends GetxController {

  RxInt index = 0.obs;
  RxBool isActive = false.obs;

  toggleIndex(int indexx){
    index.value = indexx;
  }


  toggleisActive(){
    isActive.value = !isActive.value;
  }


}