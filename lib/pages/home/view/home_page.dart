import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/logic/models/models.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/services/authentication.dart';
import 'package:arcon/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key){
    Get.find<UserController>().bindUser();
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: CustomColors.grey[2],
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            return SingleChildScrollView(
              child: Container(
                height: App.screenHeight,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12)
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.0475
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.0275,
                    vertical: App.screenHeight * 0.04,
                ),
                child: GetX<UserController>(
                  builder: (controller) {
                    if(controller.user.value.type == "admin"){
                      return Column(
                        children: [

                          SizedBox(
                            height: App.screenHeight * 0.06,
                          ),

                          Expanded(
                            child: FirestoreListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                query: UserDatabase.usersCollection.where("type", isEqualTo: "user"),
                                pageSize: 10,
                                itemBuilder: (context, querySnapshot, index, length) {
                                  return UserItem(user: User.fromDocumentSnapshot(querySnapshot));
                                }
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  flex: ResponsiveWidget.isExtraSmallScreen()
                                      ? 14 : ResponsiveWidget.isSmallScreen()
                                      ? 15 : ResponsiveWidget.isMediumScreen()
                                      ? 16 : 17,
                                  child: Container(
                                    height: Constants.screenHeight * 0.07,
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.0275
                                    ),
                                    child: GetX<UserController>(
                                        builder: (controller) {
                                          return CustomText(
                                              controller.user.value.name.toUpperCase(),
                                              style: TextStyles(
                                                  color: CustomColors.grey[5]
                                              ).textBodyLarge
                                          );
                                        }
                                    ),
                                  )
                              ),

                              SizedBox(width: width * 0.0275),

                              Container(
                                height: Constants.screenHeight * 0.07,
                                width: 2,
                                color: CustomColors.grey[3],
                              ),

                              SizedBox(width: width * 0.0275),

                              Expanded(
                                  flex: ResponsiveWidget.isExtraSmallScreen()
                                      ? 6 : ResponsiveWidget.isSmallScreen()
                                      ? 5 : ResponsiveWidget.isMediumScreen()
                                      ? 4 : 3,
                                  child: CustomButton(
                                      text: "LOGOUT",
                                      color: Colors.white,
                                      textColor: CustomColors.grey[5],
                                      onPressed: () async {
                                        await Auth().signOut();
                                        Get.offAllNamed(signInRoute);
                                      }
                                  )
                              ),
                            ],
                          ),

                          SizedBox(height: App.screenHeight * 0.045)
                        ],
                      );
                    } else {
                      return Column(
                        children: [

                          SizedBox(
                            height: App.screenHeight * 0.06,
                          ),

                          CustomText(
                              "ARCON 2023",
                              style: TextStyle(
                                  fontFamily: "TomatoGroteskBold",
                                  fontSize: constraints.maxWidth * 0.11,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.1,
                                  color: CustomColors.primary
                              )
                          ),

                          SizedBox(height: App.screenHeight * 0.04),

                          const EventCountdown(),

                          SizedBox(height: App.screenHeight * 0.04),

                          ResponsiveWidget(
                            largeScreen: Row(
                              children: [
                                Expanded(child: completeRegistration(width)),

                                SizedBox(width: width * 0.05),

                                Expanded(child: viewQR(width))
                              ],
                            ),
                            smallScreen: Column(
                              children: [
                                completeRegistration(width),

                                SizedBox(
                                  height: App.screenHeight * 0.045,
                                ),

                                viewQR(width)
                              ],
                            ),
                          ),

                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                      flex: ResponsiveWidget.isExtraSmallScreen()
                                          ? 14 : ResponsiveWidget.isSmallScreen()
                                          ? 15 : ResponsiveWidget.isMediumScreen()
                                          ? 16 : 17,
                                      child: Container(
                                        height: Constants.screenHeight * 0.07,
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.0275
                                        ),
                                        child: GetX<UserController>(
                                            builder: (controller) {
                                              return CustomText(
                                                  controller.user.value.name.toUpperCase(),
                                                  style: TextStyles(
                                                      color: CustomColors.grey[5]
                                                  ).textBodyLarge
                                              );
                                            }
                                        ),
                                      )
                                  ),

                                  SizedBox(width: width * 0.0275),

                                  Container(
                                    height: Constants.screenHeight * 0.07,
                                    width: 2,
                                    color: CustomColors.grey[3],
                                  ),

                                  SizedBox(width: width * 0.0275),

                                  Expanded(
                                      flex: ResponsiveWidget.isExtraSmallScreen()
                                          ? 6 : ResponsiveWidget.isSmallScreen()
                                          ? 5 : ResponsiveWidget.isMediumScreen()
                                          ? 4 : 3,
                                      child: CustomButton(
                                          text: "LOGOUT",
                                          color: Colors.white,
                                          textColor: CustomColors.grey[5],
                                          onPressed: () async {
                                            await Auth().signOut();
                                            Get.offAllNamed(signInRoute);
                                          }
                                      )
                                  ),
                                ],
                              )
                          ),

                          SizedBox(height: App.screenHeight * 0.045)
                        ],
                      );
                    }
                  }
                ),
              ),
            );
          }
        )
    );
  }

  Widget completeRegistration(double width) {
    return GetX<UserController>(
          builder: (controller) {

            final user = controller.user.value;
            double progress = user.getRegistrationProgress();

            bool isRegistered = progress == 1;

            return Container(
                height: ResponsiveWidget.isExtraSmallScreen()
                    ? App.screenHeight * .18: ResponsiveWidget.isSmallScreen()
                    ? App.screenHeight * .16 : ResponsiveWidget.isMediumScreen()
                    ? App.screenHeight * .15 : App.screenHeight * .18,
                width: width,
                decoration: BoxDecoration(
                    color: isRegistered ? CustomColors.success[3] : CustomColors.primary[3],
                    borderRadius: const BorderRadius.all(
                        Radius.circular(12)
                    )
                ),
                child: MaterialButton(
                  minWidth: width,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(12)
                      )
                  ),
                  onPressed: () {
                    if(!isRegistered) {
                      Get.toNamed(registrationRoute);
                    }
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
                                  isRegistered ? "Your registration is complete!"
                                      : "Complete your registration",
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

                                if(!isRegistered)
                                  SizedBox(
                                      height: ResponsiveWidget.isLargeScreen()
                                      ? constraints.maxHeight * 0.64 * 0.10 : ResponsiveWidget.isMediumScreen()
                                      ? constraints.maxHeight * 0.64 * 0.09 : ResponsiveWidget.isSmallScreen()
                                      ? constraints.maxHeight * 0.64 * 0.08: constraints.maxHeight * 0.64 * 0.06
                                  ),

                                if(!isRegistered)
                                  CustomText(
                                    "CLICK TO CONTINUE",
                                    style: TextStyle(
                                        fontFamily: "TomatoGrotesk",
                                        fontSize: ResponsiveWidget.isLargeScreen()
                                            ? constraints.maxHeight * 0.64 * 0.23 : ResponsiveWidget.isMediumScreen()
                                            ? constraints.maxHeight * 0.64 * 0.21 : ResponsiveWidget.isSmallScreen()
                                            ? constraints.maxHeight * 0.64 * 0.19 : constraints.maxHeight * 0.64 * 0.15,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.1,
                                        color: CustomColors.primary[2]
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
                        ],
                      );
                    }
                  ),
                )
            );
          }
      );
  }

  Widget viewQR(double width) {
    return GetX<UserController>(
        builder: (controller) {

          final user = controller.user.value;
          double progress = user.getRegistrationProgress();

          bool isRegistered = progress == 1;

          return Container(
              height: ResponsiveWidget.isExtraSmallScreen()
                  ? App.screenHeight * .18: ResponsiveWidget.isSmallScreen()
                  ? App.screenHeight * .16 : ResponsiveWidget.isMediumScreen()
                  ? App.screenHeight * .15 : App.screenHeight * .18,
              width: width,
              decoration: BoxDecoration(
                  color: CustomColors.secondaryOrange[3],
                  borderRadius: const BorderRadius.all(
                      Radius.circular(12)
                  )
              ),
              child: MaterialButton(
                minWidth: width,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(12)
                    )
                ),
                onPressed: () {
                  if(isRegistered) {
                    Get.toNamed('$qrRoute/${Get.find<UserController>().user.value.id}&&${Get.find<UserController>().user.value.email}');
                  } else {
                    Snack.show(
                        message: "Your need to complete your registration"
                            " before you can view your QR",
                        type: SnackBarType.info
                    );
                  }
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
                            unselectedColor: CustomColors.secondaryOrange[2],
                            selectedColor: CustomColors.secondaryOrange,
                            currentStep: (progress * 10).floor(),
                            child: Center(
                              child: Icon(
                                Icons.qr_code_rounded,
                                color: CustomColors.secondaryOrange,
                                size: ResponsiveWidget.isLargeScreen()
                                    ? constraints.maxHeight * 0.64 * 0.46 : ResponsiveWidget.isMediumScreen()
                                    ? constraints.maxHeight * 0.64 * 0.45 : ResponsiveWidget.isSmallScreen()
                                    ? constraints.maxHeight * 0.64 * 0.44 : constraints.maxHeight * 0.64 * 0.40,
                              )
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
                                  "View your event QR",
                                  style: TextStyle(
                                      fontFamily: "TomatoGrotesk",
                                      fontSize: ResponsiveWidget.isLargeScreen()
                                          ? constraints.maxHeight * 0.64 * 0.26 : ResponsiveWidget.isMediumScreen()
                                          ? constraints.maxHeight * 0.64 * 0.25 : ResponsiveWidget.isSmallScreen()
                                          ? constraints.maxHeight * 0.64 * 0.24 : constraints.maxHeight * 0.64 * 0.20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.1,
                                      color: CustomColors.secondaryOrange
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
                                  "CLICK TO VIEW",
                                  style: TextStyle(
                                      fontFamily: "TomatoGrotesk",
                                      fontSize: ResponsiveWidget.isLargeScreen()
                                          ? constraints.maxHeight * 0.64 * 0.23 : ResponsiveWidget.isMediumScreen()
                                          ? constraints.maxHeight * 0.64 * 0.21 : ResponsiveWidget.isSmallScreen()
                                          ? constraints.maxHeight * 0.64 * 0.19 : constraints.maxHeight * 0.64 * 0.15,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.1,
                                      color: CustomColors.secondaryOrange[2]
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
                        ],
                      );
                    }
                ),
              )
          );
        }
    );
  }
}
