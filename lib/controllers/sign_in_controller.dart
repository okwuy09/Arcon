import 'package:get/get.dart';

class SignInController extends GetxController{

  RxString emailAddress = "".obs;
  RxString emailAddressError = "".obs;

  RxString password = "".obs;
  RxString passwordError = "".obs;

  RxBool isPasswordVisible = false.obs;
}