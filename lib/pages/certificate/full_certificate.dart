import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/services/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:screenshot/screenshot.dart';

class FullCertificate {
  final ScreenshotController screenshotController;
  final String userName;
  final String userEmail;
  const FullCertificate({Key? key, required this.screenshotController, required this.userName, required this.userEmail});

  Future<void> sendEmail() async {
    screenshotController.captureFromWidget(Body(userName: userName, userEmail: userEmail)).then((capturedImage) async {
      try {
        UploadTask? task = Storage().uploadData("certificates", capturedImage, "${DateTime.now()}.png");

        if(task == null) {
          App.stopLoading();
          return;
        }

        final snapshot = await task.whenComplete(() {});
        final imageUrl = await snapshot.ref.getDownloadURL();

        await Messaging().sendEmail(
            recipient: [userEmail],
            message: {
              'subject': 'ARCON 2023 Conference',
              'text': 'Thank you for attending!\n\nAttached to this email is your certificate of participation',
              'attachments': {
                'filename': 'certificate.png',
                'path': imageUrl
              }
            }
        );
      } catch (e) {
        App.stopLoading();
        if (kDebugMode) print(e);
      }
    });
  }
}

class Body extends StatelessWidget {
  final String userName;
  final String userEmail;

  const Body({Key? key, required this.userName, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: App.screenHeight * 0.8,
      width: 600,
      color: Colors.white,
      child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [

                Image.asset(
                  'assets/images/certificate.png',
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),

                Container(
                  height: App.screenHeight,
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.075
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Expanded(flex: 15, child: SizedBox()),

                      SizedBox(
                        width: double.infinity,
                        child: CustomText(
                            userName.toUpperCase(),
                            style: TextStyle(
                                fontFamily: "TomatoGrotesk",
                                fontSize: ResponsiveWidget.isLargeScreen()
                                    ? App.screenHeight * 0.135 * 0.15 : ResponsiveWidget.isMediumScreen()
                                    ? App.screenHeight * 0.135 * 0.14 : ResponsiveWidget.isSmallScreen()
                                    ? App.screenHeight * 0.135 * 0.13 : App.screenHeight * 0.135 * 0.12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                                color: CustomColors.grey[5]
                            )
                        ),
                      ),

                      const Expanded(flex: 17, child: SizedBox()),

                    ],
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}