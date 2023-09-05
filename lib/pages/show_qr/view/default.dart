import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/pages/show_qr/show_qr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class ShowQr extends StatefulWidget {

  const ShowQr({Key? key}) : super(key: key);

  @override
  State<ShowQr> createState() => _ShowQrState();
}

class _ShowQrState extends State<ShowQr> {

  late String userID;
  late String userEmail;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    final fields = Get.currentRoute.split("/").last;

    userID = fields.split("&&").first;
    userEmail = fields.split("&&").last;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWrapper(
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

                      SizedBox(height: App.screenHeight * 0.04),

                      CustomButton(
                        text: "DONE",
                        margin: EdgeInsets.symmetric(
                          horizontal: ResponsiveWidget.isLargeScreen()
                              ? constraints.maxWidth * 0.25 : ResponsiveWidget.isMediumScreen()
                              ? constraints.maxWidth * 0.2 : ResponsiveWidget.isSmallScreen()
                              ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.1
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),

                      SizedBox(height: App.screenHeight * 0.02),

                      CustomButton(
                        text: "SEND TO EMAIL",
                        margin: EdgeInsets.symmetric(
                          horizontal: ResponsiveWidget.isLargeScreen()
                              ? constraints.maxWidth * 0.25 : ResponsiveWidget.isMediumScreen()
                              ? constraints.maxWidth * 0.2 : ResponsiveWidget.isSmallScreen()
                              ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.1
                        ),
                        textColor: CustomColors.primary,
                        borderColor: CustomColors.primary,
                        color: Colors.white,
                        onPressed: () async {
                          App.startLoading();
                          await ShowFullQr(
                            screenshotController: screenshotController,
                            userID: userID,
                            userEmail: userEmail,
                          ).sendEmail();
                          if(Get.find<UserController>().isLoading){
                            App.stopLoading();
                            Snack.show(message: "Email sent successfully", type: SnackBarType.info);
                          }
                        },
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
    );
  }
}
