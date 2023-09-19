import 'package:arcon/logic/models/models.dart';
import 'package:get/get.dart';

class CertificateController extends GetxController{

  Rx<User> user = User.empty().obs;

  RxString experience = "".obs;
  RxString experienceError = "".obs;

  RxString highlight1 = "".obs;
  RxString highlight2 = "".obs;
  RxString highlight3 = "".obs;
  RxString highlightsError = "".obs;

  RxString improvement1 = "".obs;
  RxString improvement2 = "".obs;
  RxString improvement3 = "".obs;
  RxString improvementsError = "".obs;

  RxString recommendation1 = "".obs;
  RxString recommendation2 = "".obs;
  RxString recommendation3 = "".obs;
  RxString recommendationsError = "".obs;

  RxString takeout1 = "".obs;
  RxString takeout2 = "".obs;
  RxString takeout3 = "".obs;
  RxString takeoutError = "".obs;

  RxString seeNext1 = "".obs;
  RxString seeNext2 = "".obs;
  RxString seeNext3 = "".obs;
  RxString seeNextError = "".obs;

  final RxInt _activeIndex = 0.obs;

  int get activeIndex => _activeIndex.value;

  void changeActiveIndex(int index) {
    _activeIndex.value = index;
  }

}