import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arcon/logic/models/models.dart';
import 'package:arcon/services/authentication.dart';

import 'package:arcon/services/database/default.dart';

class UserDatabase {
  String uID;

  UserDatabase(this.uID) {
    if (uID == "") {
      uID = Auth().uID;
    }
  }

  static CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');

  Future<void> createUser(Map<String, dynamic> values) async {
    try {
      await usersCollection.doc(uID).set(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Future<void> updateUserDetails(Map<String, dynamic> values) async {
    try {
      await usersCollection.doc(uID).update(values);
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
    }
  }

  Stream<User> get user {
    if (uID.isNotEmpty) {
      return usersCollection.doc(uID).snapshots().map((documentSnapshot) {
        return User.fromDocumentSnapshot(documentSnapshot);
      });
    } else {
      return const Stream<User>.empty();
    }
  }

  Future<List<User>> getUsers(List<String> userIDs) async {
    List<User> users = [];

    userIDs.remove("");
    for (String uID in userIDs) {
      final documentSnapshot = await usersCollection.doc(uID).get();
      if (documentSnapshot.exists) {
        users.add(User.fromDocumentSnapshot(documentSnapshot));
      }
    }

    return users;
  }

  Future<User?> getUser(String id) async {
    try {
      final result = await usersCollection.where("id", isEqualTo: id).get();
      if (result.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot in result.docs) {
          return User.fromDocumentSnapshot(documentSnapshot);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      Default.showDatabaseError(e);
      return null;
    }
  }
}