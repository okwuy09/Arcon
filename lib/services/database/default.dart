import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:arcon/pages/shared/shared.dart';

class Default {

  static String errorMessage = "";

  static void showDatabaseError(FirebaseException e) {
    Default.errorMessage = e.toString().split('] ')[1];
    if (kDebugMode) {
      print(e.toString());
    }

    Snack.show(message: errorMessage, type: SnackBarType.error);
  }
}