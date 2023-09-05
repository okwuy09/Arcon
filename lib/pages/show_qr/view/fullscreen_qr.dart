import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/services/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:screenshot/screenshot.dart';

class ShowFullQr {
  final ScreenshotController screenshotController;
  final String userID;
  final String userEmail;
  const ShowFullQr({Key? key, required this.screenshotController, required this.userID, required this.userEmail});

  Future<void> sendEmail() async {
    screenshotController.captureFromWidget(Body(userID: userID, userEmail: userEmail)).then((capturedImage) async {
      try {
        UploadTask? task = Storage().uploadData("event_qrs", capturedImage, "${DateTime.now()}.png");

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
              'text': 'Thank you for registering!\n\nAttached to this email is your event QR',
              'attachments': {
                'filename': 'event_qr.png',
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
  final String userID;
  final String userEmail;

  const Body({Key? key, required this.userID, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: App.screenHeight * 0.8,
      width: 600,
      color: CustomColors.primary[3],
      child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: App.screenHeight,
              padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.075
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                    width: double.infinity,
                    height: App.screenHeight * 0.08,
                  ),

                  CustomText(
                      "ARCON 2023",
                      style: TextStyle(
                          fontFamily: "TomatoGroteskBold",
                          fontSize: ResponsiveWidget.isLargeScreen()
                              ? App.screenHeight * 0.5 * 0.15 : ResponsiveWidget.isMediumScreen()
                              ? App.screenHeight * 0.5 * 0.14 : ResponsiveWidget.isSmallScreen()
                              ? App.screenHeight * 0.5 * 0.13 : App.screenHeight * 0.5 * 0.12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.1,
                          color: CustomColors.primary
                      )
                  ),

                  SizedBox(height: App.screenHeight * 0.025),

                  CustomText(
                    "Thank you for registering for ARCON 2023. "
                        "Below is your personal QR which will be used to "
                        "grant you entry at the venue.",
                    style: TextStyle(
                        fontFamily: "TomatoGrotesk",
                        fontSize: ResponsiveWidget.isLargeScreen()
                            ? App.screenHeight * 0.5 * 0.055 : ResponsiveWidget.isMediumScreen()
                            ? App.screenHeight * 0.5 * 0.05 : ResponsiveWidget.isSmallScreen()
                            ? App.screenHeight * 0.5 * 0.045 : App.screenHeight * 0.5 * 0.04,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.1,
                        color: CustomColors.grey[5]
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: App.screenHeight * 0.04),

                  LayoutBuilder(
                      builder: (context, innerConstraints) {
                        double qrSize = ResponsiveWidget.isLargeScreen()
                            ? App.screenHeight * 0.5 * 0.725 : ResponsiveWidget.isMediumScreen()
                            ? App.screenHeight * 0.5 * 0.75 : ResponsiveWidget.isSmallScreen()
                            ? App.screenHeight * 0.5 * 0.775 : App.screenHeight * 0.5 * 0.8;

                        return Container(
                          width: qrSize,
                          height: qrSize,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(12)
                              )
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: qrSize * 0.05,
                              vertical: qrSize * 0.05
                          ),
                          child: QrImageView(
                            data: userID,
                            size: qrSize * 0.9,
                          ),
                        );
                      }
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: App.screenHeight * 0.08,
                  ),

                ],
              ),
            );
          }
      ),
    );
  }
}


