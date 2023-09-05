import 'dart:html' as html;

import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/services/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'dart:ui' as ui;

class ShowFullQr extends StatefulWidget {

  const ShowFullQr({Key? key}) : super(key: key);

  @override
  State<ShowFullQr> createState() => _ShowFullQrState();
}

class _ShowFullQrState extends State<ShowFullQr> {

  late String userID;
  late String userEmail;

  final GlobalKey _repaintKey = GlobalKey();

  @override
  void initState() {
    final fields = Get.currentRoute.split("/").last;

    userID = fields.split("&&").first;
    userEmail = fields.split("&&").last;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => sendEmail());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  RepaintBoundary(
      key: _repaintKey,
      child: LoadingWrapper(
        child: Scaffold(
          backgroundColor: CustomColors.primary[3],
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Container(
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
                          height: App.screenHeight * 0.1,
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
                          height: App.screenHeight * 0.1,
                        ),

                      ],
                    ),
                  ),
                );
              }
            )
        ),
      ),
    );
  }

  Future<void> sendEmail() async {
    try {
      RenderRepaintBoundary? boundary = _repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if(boundary == null) return;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if(byteData == null) return;

      Uint8List pngBytes = byteData.buffer.asUint8List();

      UploadTask? task = Storage().uploadData("event_qrs", pngBytes, "${DateTime.now()}.png");

      if(task == null) return;

      App.startLoading();

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

      App.stopLoading();

      Snack.show(message: "Email sent successfully", type: SnackBarType.info);

      Future.delayed(const Duration(milliseconds: 2000), () {html.window.close();});

    } catch (e) {
      App.stopLoading();
      if (kDebugMode) print(e);
    }
  }
}
