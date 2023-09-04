import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

class PageFive extends StatelessWidget {
  const PageFive ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, constraints) {

          return GetX<UserController>(
              builder: (controller) {
                if(controller.user.value.details["paymentSubmitted"] == "true"){
                  if(controller.user.value.details["paymentConfirmed"] == "true") {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: App.screenHeight * 0.06,
                        ),

                        CustomText(
                            "Your payment has been confirmed!",
                            style: TextStyle(
                                fontFamily: "TomatoGroteskBold",
                                fontSize: constraints.maxHeight * 0.5 * 0.10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.1,
                                color: CustomColors.grey[5]
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                        ),

                        SizedBox(height: App.screenHeight * 0.05),

                        CustomButton(
                          text: "VIEW EVENT QR",
                          margin: EdgeInsets.symmetric(
                              horizontal: ResponsiveWidget.isLargeScreen()
                                  ? constraints.maxWidth * 0.25 : ResponsiveWidget.isMediumScreen()
                                  ? constraints.maxWidth * 0.2 : ResponsiveWidget.isSmallScreen()
                                  ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.1
                          ),
                          onPressed: () {
                            Get.offAndToNamed(qrRoute, arguments: {
                              "hasSentEmail": false
                            });
                          },
                        ),

                        SizedBox(height: App.screenHeight * 0.01),

                        CustomButton(
                          text: "RETURN",
                          margin: EdgeInsets.symmetric(
                              horizontal: ResponsiveWidget.isLargeScreen()
                                  ? constraints.maxWidth * 0.25 : ResponsiveWidget.isMediumScreen()
                                  ? constraints.maxWidth * 0.2 : ResponsiveWidget.isSmallScreen()
                                  ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.1
                          ),
                          borderColor: CustomColors.primary,
                          color: Colors.white,
                          textColor: CustomColors.primary,
                          onPressed: () {
                            Get.back();
                          },
                        ),

                        SizedBox(
                          height: App.screenHeight * 0.06,
                        ),

                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: App.screenHeight * 0.06,
                        ),

                        CustomText(
                            "Your payment is being confirmed...",
                            style: TextStyle(
                                fontFamily: "TomatoGroteskBold",
                                fontSize: constraints.maxHeight * 0.5 * 0.10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.1,
                                color: CustomColors.grey[5]
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                        ),

                        SizedBox(height: App.screenHeight * 0.05),

                        CustomButton(
                          text: "CANCEL AND RETRY",
                          margin: EdgeInsets.symmetric(
                              horizontal: ResponsiveWidget.isLargeScreen()
                                  ? constraints.maxWidth * 0.25 : ResponsiveWidget.isMediumScreen()
                                  ? constraints.maxWidth * 0.2 : ResponsiveWidget.isSmallScreen()
                                  ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.1
                          ),
                          onPressed: () async {
                            final user = Get.find<UserController>().user.value;

                            App.startLoading();

                            user.details["paymentProof"] = "";
                            user.details["paymentSubmitted"] = "false";

                            await UserDatabase(user.id).updateUserDetails(user.toJson());

                            App.stopLoading();
                          },
                        ),

                        SizedBox(height: App.screenHeight * 0.01),

                        CustomButton(
                          text: "RETURN",
                          margin: EdgeInsets.symmetric(
                              horizontal: ResponsiveWidget.isLargeScreen()
                                  ? constraints.maxWidth * 0.25 : ResponsiveWidget.isMediumScreen()
                                  ? constraints.maxWidth * 0.2 : ResponsiveWidget.isSmallScreen()
                                  ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.1
                          ),
                          borderColor: CustomColors.primary,
                          color: Colors.white,
                          textColor: CustomColors.primary,
                          onPressed: () {
                            Get.back();
                          },
                        ),

                        SizedBox(
                          height: App.screenHeight * 0.06,
                        ),

                      ],
                    );
                  }
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: App.screenHeight * 0.06,
                      ),

                      CustomText(
                          "CONVENTION FEE",
                          style: TextStyle(
                              fontFamily: "TomatoGrotesk",
                              fontSize: constraints.maxHeight * 0.5 * 0.07,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.1,
                              color: CustomColors.grey[5]
                          )
                      ),

                      SizedBox(height: App.screenHeight * 0.01),

                      CustomText(
                          "₦60,000",
                          style: TextStyle(
                              fontFamily: "TomatoGroteskBold",
                              fontSize: constraints.maxHeight * 0.5 * 0.15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.1,
                              color: CustomColors.primary
                          )
                      ),

                      SizedBox(height: App.screenHeight * 0.02),

                      CustomText(
                        "For manual payment, make a bank transfer to the account below then submit proof of payment",
                        style: TextStyle(
                            fontFamily: "TomatoGrotesk",
                            fontSize: constraints.maxHeight * 0.5 * 0.06,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                            color: CustomColors.grey[5]
                        ),
                        maxLines: 10,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: App.screenHeight * 0.02),

                      CustomText(
                          "United Bank for Africa",
                          style: TextStyle(
                              fontFamily: "TomatoGrotesk",
                              fontSize: constraints.maxHeight * 0.5 * 0.08,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.1,
                              color: CustomColors.grey[5]
                          )
                      ),

                      SizedBox(height: App.screenHeight * 0.005),

                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(const ClipboardData(text: "1026251159"));
                          Snack.show(
                              message: "Account number copied successfully",
                              type: SnackBarType.success
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                                "1026251159",
                                style: TextStyle(
                                    fontFamily: "TomatoGroteskBold",
                                    fontSize: constraints.maxHeight * 0.5 * 0.13,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.1,
                                    color: CustomColors.primary
                                )
                            ),

                            SizedBox(width: App.screenHeight * 0.02),

                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * 0.5 * 0.01,
                                horizontal: constraints.maxHeight * 0.5 * 0.02,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CustomColors.primary,
                                      width: 1
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)
                                  )
                              ),
                              child: CustomText(
                                  "COPY",
                                  style: TextStyle(
                                      fontFamily: "TomatoGrotesk",
                                      fontSize: constraints.maxHeight * 0.5 * 0.05,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.1,
                                      color: CustomColors.primary
                                  )
                              ),
                            )

                          ],
                        ),
                      ),

                      SizedBox(height: App.screenHeight * 0.005),

                      CustomText(
                        "ASSOCIATION OF RADIATION AND CLINICAL ONCOLOGISTS OF NIGERIA LOC",
                        style: TextStyle(
                            fontFamily: "TomatoGrotesk",
                            fontSize: constraints.maxHeight * 0.5 * 0.06,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.1,
                            color: CustomColors.grey[5]
                        ),
                        maxLines: 4,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: App.screenHeight * 0.01),

                      CustomButton(
                        text: "UPLOAD PROOF",
                        margin: EdgeInsets.symmetric(
                            horizontal: ResponsiveWidget.isLargeScreen()
                                ? constraints.maxWidth * 0.25 : ResponsiveWidget.isMediumScreen()
                                ? constraints.maxWidth * 0.2 : ResponsiveWidget.isSmallScreen()
                                ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.1
                        ),
                        borderColor: CustomColors.primary,
                        color: Colors.white,
                        textColor: CustomColors.primary,
                        onPressed: () {
                          selectProof();
                        },
                      ),

                      SizedBox(height: App.screenHeight * 0.03),
/*
                      CustomText(
                        "For automatic payment, click on the button below.",
                        style: TextStyle(
                            fontFamily: "TomatoGrotesk",
                            fontSize: constraints.maxHeight * 0.5 * 0.06,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.1,
                            color: CustomColors.grey[5]
                        ),
                        maxLines: 4,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: App.screenHeight * 0.01),

                      CustomButton(
                        text: "PAY NOW",
                        margin: EdgeInsets.symmetric(
                            horizontal: ResponsiveWidget.isLargeScreen()
                                ? constraints.maxWidth * 0.25 : ResponsiveWidget.isMediumScreen()
                                ? constraints.maxWidth * 0.2 : ResponsiveWidget.isSmallScreen()
                                ? constraints.maxWidth * 0.15 : constraints.maxWidth * 0.1
                        ),
                        borderColor: CustomColors.primary,
                        color: Colors.white,
                        textColor: CustomColors.primary,
                        onPressed: () {
                          payNow();
                        },
                      ),*/
                    ],
                  );
                }
            }
          );
        }
    );
  }

  void selectProof() async {
    final imageFile = await ImagePickerWeb.getImageInfo;
    if (imageFile != null) {
      Get.find<RegistrationController>().setProofImage(imageFile);
      Get.find<RegistrationController>().hasFinished.value = true;
    }
  }

  void payNow() async {}
}
