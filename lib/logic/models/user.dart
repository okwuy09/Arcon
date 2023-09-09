import 'package:arcon/services/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase;

class User {
  late String id,
      name,
      email,
      type,
      phoneNumber,
      gender,
      institution,
      credentials;
  late int number;
  late bool hasBeenValidated;
  late Map<String, dynamic> details;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.number,
    this.type = "user",
    this.phoneNumber = "",
    this.gender = "",
    this.institution = "",
    this.credentials = "",
    this.hasBeenValidated = false,
    this.details = const {
      "resident": "",
      "area": "",
      "speaker": "",
      "attending": "",
      "dinner": "",
      "reservations": "",
      "assistance": "",
      "psychoOncology": "",
      "badNews": "",
      "brachytherapy": "",
      "hasFinished": "false",
      "paymentSubmitted": "false",
      "paymentConfirmed": "false",
      "paymentProof": "",
    },
  });

  User.empty(){
    id =  '';
    name = '';
    email = '';
    number = 0;
    type = 'user';
    phoneNumber = '';
    gender = '';
    institution = '';
    credentials = '';
    hasBeenValidated = false;
    details = {
      "resident": "",
      "area": "",
      "speaker": "",
      "attending": "",
      "dinner": "",
      "reservations": "",
      "assistance": "",
      "psychoOncology": "",
      "badNews": "",
      "brachytherapy": "",
      "hasFinished": "false",
      "paymentSubmitted": "false",
      "paymentConfirmed": "false",
      "paymentProof": "",
    };
  }

  User.fromDocumentSnapshot(firebase.DocumentSnapshot snapshot){
    id = snapshot.get("id") ?? "";
    name = snapshot.get("name") ?? "";

    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    number = data["number"] ?? 0;

    email = snapshot.get("email") ?? "";
    type = snapshot.get("type") ?? "";
    phoneNumber = snapshot.get("phoneNumber") ?? "";
    gender = snapshot.get("gender") ?? "";
    institution = snapshot.get("institution") ?? "";
    credentials = snapshot.get("credentials") ?? "";
    hasBeenValidated = snapshot.get("hasBeenValidated") ?? false;
    details = snapshot.get("details");
    if(number == 0 && type == "user"){
      UserDatabase(id).assignNumber(email);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "name" : name,
      "email" : email,
      "number" : number,
      "type" : type,
      "phoneNumber" : phoneNumber,
      "gender" : gender,
      "institution" : institution,
      "credentials" : credentials,
      "hasBeenValidated" : hasBeenValidated,
      "details" : details,
    };
  }

  double getRegistrationProgress() {
    const int totalItems = 19;
    int filledItems = 0;

    if(name.isNotEmpty) filledItems++;
    if(email.isNotEmpty) filledItems++;
    if(phoneNumber.isNotEmpty) filledItems++;
    if(gender.isNotEmpty) filledItems++;
    if(institution.isNotEmpty) filledItems++;
    if(credentials.isNotEmpty) filledItems++;

    if(details["resident"].toString().isNotEmpty) filledItems++;
    if(details["area"].toString().isNotEmpty) filledItems++;
    if(details["speaker"].toString().isNotEmpty) filledItems++;
    if(details["attending"].toString().isNotEmpty) filledItems++;
    if(details["resident"].toString().isNotEmpty) filledItems++;
    if(details["dinner"].toString().isNotEmpty) filledItems++;
    if(details["reservations"].toString().isNotEmpty) filledItems++;
    if(details["assistance"].toString().isNotEmpty) filledItems++;
    if(details["psychoOncology"].toString().isNotEmpty) filledItems++;
    if(details["badNews"].toString().isNotEmpty) filledItems++;
    if(details["brachytherapy"].toString().isNotEmpty) filledItems++;

    if(details["paymentSubmitted"] == "true") filledItems++;
    if(details["paymentConfirmed"] == "true") filledItems++;

    return filledItems / totalItems;
  }
}
