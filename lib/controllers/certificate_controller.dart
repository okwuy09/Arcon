import 'package:arcon/logic/models/models.dart';
import 'package:get/get.dart';

class CertificateController extends GetxController{

  Rx<User> user = User.empty().obs;

  RxString experience = "".obs;
  RxString experienceError = "".obs;

  RxString highlights = "".obs;
  RxString highlightsError = "".obs;

  RxString improvements = "".obs;
  RxString improvementsError = "".obs;

  RxString seeNext = "".obs;
  RxString seeNextError = "".obs;
}