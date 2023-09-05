import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;
import 'package:arcon/pages/shared/shared.dart';

class Storage {

  final FirebaseStorage _storage = FirebaseStorage.instance;

  static String errorMessage = "";

  void uploadFailed(){
    Snack.show(message: errorMessage, type: SnackBarType.error, floating: true);
  }

  UploadTask? uploadImage(String destination, String prefix, MediaInfo info) {
    try {

      String mimeType = mime(path.basename(info.fileName!))!;

      final extension = extensionFromMime(mimeType);

      final reference = _storage.refFromURL('gs://arcon-2023.appspot.com')
          .child(
          "$destination/$prefix${DateTime.now().millisecondsSinceEpoch}.$extension");

      return reference.putData(info.data!, SettableMetadata(contentType: mimeType));
    } on FirebaseException catch (e) {
      errorMessage = e.toString().split('] ')[1];
      uploadFailed();
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  UploadTask? uploadData(String destination, Uint8List uint8list, String filename) {
    try {
      final reference = _storage.refFromURL('gs://arcon-2023.appspot.com')
          .child(
          "$destination/$filename");

      return reference.putData(uint8list);
    } on FirebaseException catch (e) {
      errorMessage = e.toString().split('] ')[1];
      uploadFailed();
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  UploadTask? uploadFile(String destination, File file){
    try {
      final reference = _storage.ref(destination);
      return reference.putFile(file);
    } on FirebaseException catch (e) {
      errorMessage = e.toString().split('] ')[1];
      uploadFailed();
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}