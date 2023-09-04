import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

class RegistrationController extends GetxController{

  //TODO fill values from user bio
  RxString phoneNumber = "".obs;
  RxString phoneNumberError = "".obs;

  RxString institution = "".obs;
  RxString institutionError = "".obs;

  RxString gender = "".obs;
  RxString genderError = "".obs;

  RxString resident = "".obs;
  RxString residentError = "".obs;

  RxString credentials = "".obs;
  RxString credentialsError = "".obs;
  RxString otherCredential = "".obs;
  RxString otherCredentialError = "".obs;

  RxString area = "".obs;
  RxString areaError = "".obs;

  RxString speaker = "".obs;
  RxString speakerError = "".obs;

  RxString attending = "".obs;
  RxString attendingError = "".obs;

  RxString dinner = "".obs;
  RxString dinnerError = "".obs;

  RxString reservations = "".obs;
  RxString reservationsError = "".obs;

  RxString assistance = "".obs;
  RxString assistanceError = "".obs;

  RxString psychoOncology = "".obs;
  RxString psychoOncologyError = "".obs;

  RxString badNews = "".obs;
  RxString badNewsError = "".obs;

  RxString brachytherapy = "".obs;
  RxString brachytherapyError = "".obs;

  RxBool hasFinished = false.obs;
  RxBool paymentSubmitted = false.obs;
  RxBool paymentConfirmed = false.obs;


  Rx<MediaInfo?> rawProofImage = MediaInfo().obs;

  String get proofImage {
    return rawProofImage.value?.fileName ?? "";
  }

  MediaInfo getProofImage() {
    return rawProofImage.value!;
  }

  void setProofImage (MediaInfo info) {
    rawProofImage.value = info;
  }

  int tabLength = 5;

  RxInt currentTab = 0.obs;

  void changeTab(int newTabIndex) {
    currentTab.value = newTabIndex;
  }
}