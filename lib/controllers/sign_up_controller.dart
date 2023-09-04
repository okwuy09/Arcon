import 'package:get/get.dart';

class SignUpController extends GetxController{

  RxString name = "".obs;
  RxString nameError = "".obs;

  RxString emailAddress = "".obs;
  RxString emailAddressError = "".obs;

  RxString userType = "user".obs;

  RxString password = "".obs;
  RxString passwordError = "".obs;

  RxBool isPasswordVisible = false.obs;
}