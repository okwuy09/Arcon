import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  static String errorMessage = "";

  bool get isSignedIn {
    if (_auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  String get uID {
    if(isSignedIn){
      return _auth.currentUser!.uid;
    }else {
      return "";
    }
  }

  void authFailed(){
    Snack.show(message: errorMessage, type: SnackBarType.error);
  }

  Future<String> signUp(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return user.user?.uid ?? "";
    } on FirebaseAuthException catch (e) {
      errorMessage = e.toString().split('] ')[1];
      if (kDebugMode) {
        print(e.toString());
      }
      return "";
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user.user?.uid ?? "";
    } on Exception catch (e) {
      errorMessage = e.toString().split('] ')[1];
      if (kDebugMode) {
        print(e.toString());
      }
      return "";
    }
  }

  Future<bool> resetPassword(String emailAddress) async  {
    try {
      await _auth.sendPasswordResetEmail(email: emailAddress);
      return true;
    } on Exception catch (e) {
      errorMessage = e.toString().split('] ')[1];
      authFailed();
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<void> signOut() async {
    Get.find<UserController>().clearAll();
    await _auth.signOut();
  }
}
