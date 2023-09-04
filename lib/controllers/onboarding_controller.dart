import 'package:get/get.dart';

class OnboardingController extends GetxController{

  RxString entryType = "".obs;

  RxString name = "".obs;

  RxString emailAddress = "".obs;

  RxString userType = "".obs;

  RxString password = "".obs;

  final RxInt _activeIndex = 0.obs;

  void changeActiveIndex(int newIndex) {
    _activeIndex.value = newIndex;
  }

  int get activeIndex  => _activeIndex.value;
}