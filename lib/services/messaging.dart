import 'package:cloud_firestore/cloud_firestore.dart';

class Messaging {

  static CollectionReference mailCollection = FirebaseFirestore.instance
      .collection('mail');

  Future<void> sendEmail({required List<String> recipient, required Map<String, dynamic> message}) async {
   await mailCollection.add({
      "to": recipient,
      "message": message
    });

  }
}