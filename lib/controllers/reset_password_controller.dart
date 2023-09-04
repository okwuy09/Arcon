import 'package:get/get.dart';

class ResetPasswordController extends GetxController{

  RxInt currentTab = 0.obs;

  RxString emailAddress = "".obs;
  RxString emailAddressError = "".obs;

  RxBool isPasswordVisible = false.obs;
  RxString password = "".obs;
  RxString passwordError = "".obs;

  void changeTab(int newTabIndex) {
    currentTab.value = newTabIndex;
  }
}