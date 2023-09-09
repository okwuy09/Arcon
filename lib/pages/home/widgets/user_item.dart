import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/logic/models/models.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class UserItem extends StatelessWidget {
  final User user;
  const UserItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = user.getRegistrationProgress();

    bool isRegistered = progress == 1;
    bool isPaymentSubmitted = user.details["paymentSubmitted"] == "true";
    bool isPaymentConfirmed = user.details["paymentConfirmed"] == "true";

    return Container(
      height: App.screenHeight * 0.12,
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom:  App.screenHeight * 0.01
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12)
        ),
        color: isRegistered ? CustomColors.success[3] : CustomColors.primary[3]
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: MaterialButton(
              minWidth: double.infinity,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(12),
                  )
              ),
              onPressed: () {
                Get.toNamed(userDataRoute, arguments: {"user": user});
              },
              child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: ResponsiveWidget.isLargeScreen()
                                ? constraints.maxHeight * 0.64 * 0.30 : ResponsiveWidget.isMediumScreen()
                                ? constraints.maxHeight * 0.64 * 0.29 : ResponsiveWidget.isSmallScreen()
                                ? constraints.maxHeight * 0.64 * 0.28: constraints.maxHeight * 0.64 * 0.26
                        ),

                        CircularStepProgressIndicator(
                          totalSteps: 10,
                          height: constraints.maxHeight * 0.64,
                          width: constraints.maxHeight * 0.64,
                          unselectedColor: isRegistered ? CustomColors.success[2] : CustomColors.primary[2],
                          selectedColor: isRegistered ? CustomColors.success : CustomColors.primary,
                          currentStep: (progress * 10).floor(),
                          child: Center(
                            child: CustomText(
                                "${(progress * 100).toInt()}%",
                                style: TextStyle(
                                    fontFamily: "TomatoGrotesk",
                                    fontSize: ResponsiveWidget.isLargeScreen()
                                        ? constraints.maxHeight * 0.64 * 0.26 : ResponsiveWidget.isMediumScreen()
                                        ? constraints.maxHeight * 0.64 * 0.25 : ResponsiveWidget.isSmallScreen()
                                        ? constraints.maxHeight * 0.64 * 0.24 : constraints.maxHeight * 0.64 * 0.20,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.1,
                                    color: isRegistered ? CustomColors.success : CustomColors.primary
                                )
                            ),
                          ),
                        ),

                        SizedBox(
                            width: ResponsiveWidget.isLargeScreen()
                                ? constraints.maxHeight * 0.64 * 0.30 : ResponsiveWidget.isMediumScreen()
                                ? constraints.maxHeight * 0.64 * 0.29 : ResponsiveWidget.isSmallScreen()
                                ? constraints.maxHeight * 0.64 * 0.28: constraints.maxHeight * 0.64 * 0.26
                        ),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                user.name,
                                style: TextStyle(
                                    fontFamily: "TomatoGrotesk",
                                    fontSize: ResponsiveWidget.isLargeScreen()
                                        ? constraints.maxHeight * 0.64 * 0.26 : ResponsiveWidget.isMediumScreen()
                                        ? constraints.maxHeight * 0.64 * 0.25 : ResponsiveWidget.isSmallScreen()
                                        ? constraints.maxHeight * 0.64 * 0.24 : constraints.maxHeight * 0.64 * 0.20,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.1,
                                    color: isRegistered ? CustomColors.success : CustomColors.primary
                                ),
                                maxLines: 3,
                                textAlign: TextAlign.start,
                              ),

                              SizedBox(
                                  height: ResponsiveWidget.isLargeScreen()
                                      ? constraints.maxHeight * 0.64 * 0.10 : ResponsiveWidget.isMediumScreen()
                                      ? constraints.maxHeight * 0.64 * 0.09 : ResponsiveWidget.isSmallScreen()
                                      ? constraints.maxHeight * 0.64 * 0.08: constraints.maxHeight * 0.64 * 0.06
                              ),

                              CustomText(
                                "PAYMENT ${
                                    isPaymentSubmitted ? isPaymentConfirmed
                                        ? "CONFIRMED" : "NOT YET CONFIRMED" : "NOT YET MADE"}",
                                style: TextStyle(
                                    fontFamily: "TomatoGrotesk",
                                    fontSize: ResponsiveWidget.isLargeScreen()
                                        ? constraints.maxHeight * 0.64 * 0.23 : ResponsiveWidget.isMediumScreen()
                                        ? constraints.maxHeight * 0.64 * 0.21 : ResponsiveWidget.isSmallScreen()
                                        ? constraints.maxHeight * 0.64 * 0.19 : constraints.maxHeight * 0.64 * 0.15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.1,
                                    color: isRegistered ? CustomColors.success : CustomColors.primary
                                ),
                                maxLines: 3,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                            width: ResponsiveWidget.isLargeScreen()
                                ? constraints.maxHeight * 0.64 * 0.30 : ResponsiveWidget.isMediumScreen()
                                ? constraints.maxHeight * 0.64 * 0.29 : ResponsiveWidget.isSmallScreen()
                                ? constraints.maxHeight * 0.64 * 0.28: constraints.maxHeight * 0.64 * 0.26
                        ),

                        Builder(
                          builder: (context) {
                            String number = user.number.toString();

                            if(number.length == 1){
                              number = "00$number";
                            } else if(number.length == 2){
                              number = "0$number";
                            }

                            number = "ARC$number";
                            return CustomText(
                              number,
                              style: TextStyle(
                                  fontFamily: "TomatoGrotesk",
                                  fontSize: ResponsiveWidget.isLargeScreen()
                                      ? constraints.maxHeight * 0.64 * 0.26 : ResponsiveWidget.isMediumScreen()
                                      ? constraints.maxHeight * 0.64 * 0.25 : ResponsiveWidget.isSmallScreen()
                                      ? constraints.maxHeight * 0.64 * 0.24 : constraints.maxHeight * 0.64 * 0.20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.1,
                                  color: isRegistered ? CustomColors.success : CustomColors.primary
                              ),
                              maxLines: 3,
                              textAlign: TextAlign.start,
                            );
                          }
                        ),

                        SizedBox(
                            width: ResponsiveWidget.isLargeScreen()
                                ? constraints.maxHeight * 0.64 * 0.30 : ResponsiveWidget.isMediumScreen()
                                ? constraints.maxHeight * 0.64 * 0.29 : ResponsiveWidget.isSmallScreen()
                                ? constraints.maxHeight * 0.64 * 0.28: constraints.maxHeight * 0.64 * 0.26
                        ),
                      ],
                    );
                  }
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: MaterialButton(
              height: double.infinity,
              minWidth: double.infinity,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(12),
                  )
              ),
              onPressed: () async {
                App.startLoading();
                await UserDatabase(user.id).deleteUser();
                App.stopLoading();
              },
              child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: ResponsiveWidget.isLargeScreen()
                                ? constraints.maxHeight * 0.64 * 0.30 : ResponsiveWidget.isMediumScreen()
                                ? constraints.maxHeight * 0.64 * 0.29 : ResponsiveWidget.isSmallScreen()
                                ? constraints.maxHeight * 0.64 * 0.28: constraints.maxHeight * 0.64 * 0.26
                        ),

                        Icon(
                          Icons.delete,
                          color: isRegistered ? CustomColors.success : CustomColors.primary,
                          size: ResponsiveWidget.isLargeScreen()
                              ? constraints.maxHeight * 0.64 * 0.46 : ResponsiveWidget.isMediumScreen()
                              ? constraints.maxHeight * 0.64 * 0.45 : ResponsiveWidget.isSmallScreen()
                              ? constraints.maxHeight * 0.64 * 0.44 : constraints.maxHeight * 0.64 * 0.40,
                        ),

                        SizedBox(
                            width: ResponsiveWidget.isLargeScreen()
                                ? constraints.maxHeight * 0.64 * 0.30 : ResponsiveWidget.isMediumScreen()
                                ? constraints.maxHeight * 0.64 * 0.29 : ResponsiveWidget.isSmallScreen()
                                ? constraints.maxHeight * 0.64 * 0.28: constraints.maxHeight * 0.64 * 0.26
                        ),
                      ],
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
