import 'package:arcon/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Messaging {

  static CollectionReference mailCollection = FirebaseFirestore.instance
      .collection('mail');

  Future<void> sendEmail({required List<String> recipient, required Map<String, String> message}) async {
    String username = "banjokodavid4@gmail.com";

    Auth();

    final smtpServer = gmailSaslXoauth2(username, "");

    final message = Message()
      ..from = Address(username)
      ..recipients.add('shadesofthenight4@example.com')
      ..subject = 'Testing Dart Mailer plugin :: connectionEstablished :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.';

    try {
      final sendReport = await send(message, smtpServer);
      //TODO DELETE
      print("Email Sent!");
    } on MailerException catch (e) {
      if(kDebugMode){
        print(e.toString());
      }
    }

    /*await mailCollection.add({
      "to": recipient,
      "message": message
    });

     */
  }
}