import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxInt index = 0.obs;
  void changeIndex(int index) {
    this.index.value = index;
  }
}
