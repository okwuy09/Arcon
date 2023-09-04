import 'package:arcon/logic/models/models.dart';
import 'package:arcon/services/services.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void startLoading() => _isLoading.value = true;

  void stopLoading() => _isLoading.value = false;

  final Rx<User> user = User.empty().obs;

  void bindUser() {
    user.bindStream(UserDatabase(Auth().uID).user);
  }

  clearAll(){
    user.value = User.empty();
  }
}
