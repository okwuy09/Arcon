import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/logic/models/models.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/pages/show_qr/show_qr.dart';
import 'package:arcon/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowUserData extends StatelessWidget {
  const ShowUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    User user = User.empty();

    final arguments = Get.arguments;

    if(arguments != null){
      user = arguments["user"] ?? User.empty();
    }

    bool isPaymentSubmitted = user.details["paymentSubmitted"] == "true";
    bool isPaymentConfirmed = user.details["paymentConfirmed"] == "true";

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
                        height: App.screenHeight * 0.05,
                      ),

                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(12)
                            )
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.025,
                            vertical: App.screenHeight * 0.03
                        ),
                        child: Column(
                          children: [

                            item(
                              title: "Name",
                              value: user.name,
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "E-mail",
                              value: user.email,
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Phone Number",
                              value: user.phoneNumber,
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Gender",
                              value: user.gender,
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Name of institution",
                              value: user.institution,
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Credentials",
                              value: user.credentials,
                            ),

                            SizedBox(height: App.screenHeight * 0.015),
                            item(
                              title: "Are you a resident doctor?",
                              value: user.details["resident"],
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Area of identification",
                              value: user.details["area"],
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Is a speaker?",
                              value: user.details["speaker"],
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Psycho-oncology Workshop?",
                              value: user.details["psychoOncology"],
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Breaking Bad News Workshop?",
                              value: user.details["badNews"],
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Brachytherapy Workshop?",
                              value: user.details["brachytherapy"],
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Dinner Attendance",
                              value: user.details["dinner"],
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Conference Attendance",
                              value: user.details["attending"],
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Reservations?",
                              value: user.details["reservations"],
                            ),

                            SizedBox(height: App.screenHeight * 0.015),

                            item(
                              title: "Wants Assistance?",
                              value: user.details["assistance"],
                            ),

                            if((user.details["paymentProof"]?? "").toString().isNotEmpty)
                              SizedBox(height: App.screenHeight * 0.015),

                            if((user.details["paymentProof"]?? "").toString().isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse(user.details["paymentProof"]));
                                },
                                child: item(
                                  title: "Payment Proof",
                                  value: "Tap to view payment proof",
                                  isClickable: true
                                ),
                              ),
                          ],
                        )
                      ),

                      SizedBox(height: App.screenHeight * 0.025),

                      Builder(
                        builder: (context) {
                          if(isPaymentSubmitted && !isPaymentConfirmed){

                            final horizontalSpacing = SizedBox(width: constraints.maxWidth * 0.05);

                            final verticalSpacing = SizedBox(height: App.screenHeight * 0.025);

                            return ResponsiveWidget(
                                largeScreen: Row(
                                  children: [
                                    Expanded(child: confirmButton(user)),

                                    horizontalSpacing,

                                    Expanded(child: doneButton())
                                  ],
                                ),
                                mediumScreen: Row(
                                  children: [
                                    Expanded(child: confirmButton(user)),

                                    horizontalSpacing,

                                    Expanded(child: doneButton())
                                  ],
                                ),
                                smallScreen: Column(
                                  children: [

                                    confirmButton(user),

                                    verticalSpacing,

                                    doneButton()
                                  ],
                                )
                            );
                          } else {
                            return doneButton();
                          }

                        }
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: App.screenHeight * 0.05,
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

  Widget item({required String title, required String value, bool isClickable = false}) {
    return Row(
      children: [
        CustomText(
            title,
            style: TextStyle(
                fontFamily: "TomatoGrotesk",
                fontSize: App.screenHeight * 0.25 * 0.07,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
                color: CustomColors.grey[5]
            ),
        ),

        SizedBox(width: App.screenHeight * 0.01),

        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
                value.isEmpty ? "N/A" : value,
                style: TextStyle(
                    fontFamily: "TomatoGrotesk",
                    fontSize: App.screenHeight * 0.25 * 0.07,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    decoration: isClickable ? TextDecoration.underline : null,
                    color: isClickable ? CustomColors.secondaryBlue : CustomColors.grey[5]
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget confirmButton(User user) {
    final ScreenshotController screenshotController = ScreenshotController();

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomButton(
          text: "CONFIRM PAYMENT",
          margin: EdgeInsets.symmetric(
              horizontal: ResponsiveWidget.isLargeScreen()
                  ? constraints.maxWidth * 0.25 : ResponsiveWidget.isMediumScreen()
                  ? constraints.maxWidth * 0.2 : ResponsiveWidget.isSmallScreen()
                  ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.1
          ),
          borderColor: CustomColors.primary,
          color: Colors.white,
          textColor: CustomColors.primary,
          onPressed: () async {

            user.details["paymentConfirmed"] = "true";

            App.startLoading();
            await UserDatabase(user.id).updateUserDetails(user.toJson());
            App.stopLoading();

            App.startLoading();
            await ShowFullQr(
              screenshotController: screenshotController,
              userID: user.id,
              userEmail: user.email,
            ).sendEmail();

            if(Get.find<UserController>().isLoading){
              App.stopLoading();
              Snack.show(message: "Email sent successfully", type: SnackBarType.info);
              Future.delayed(const Duration(seconds: 2), () {
                Get.offAllNamed(homeRoute);
              });
            } else {
              App.stopLoading();
              Get.back();
            }
          },
        );
      }
    );
  }

  Widget doneButton() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomButton(
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
        );
      }
    );
  }
}
