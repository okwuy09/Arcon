import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/logic/models/models.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/services/authentication.dart';
import 'package:arcon/services/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                      return AdminHome(constraints: constraints);
                    } else {
                      return UserHome(constraints: constraints);
                    }
                  }
                ),
              ),
            );
          }
        )
    );
  }
}

class AdminHome extends StatefulWidget {
  final BoxConstraints constraints;
  const AdminHome({Key? key, required this.constraints}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with TickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.constraints.maxWidth;

    return Column(
      children: [

        SizedBox(
          height: App.screenHeight * 0.05,
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: App.screenHeight * 0.05,
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: CustomColors.primary),
              ),
              labelColor: CustomColors.primary,
              labelStyle: const TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
              unselectedLabelColor: CustomColors.grey[4],
              unselectedLabelStyle: const TextStyle(
                  fontFamily: 'TomatoGrotesk',
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
              onTap: (index) {},
              tabs: const [
                Tab(
                  text: "ALL",
                ),
                Tab(
                  text: "CONFIRMED",
                ),
                Tab(
                  text: "NOT CONFIRMED",
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: App.screenHeight * 0.02,
        ),

        Expanded(
          child: TabBarView(
              controller: tabController,
              children: [
                list(UserDatabase.usersCollection.where("type", isEqualTo: "user")),
                list(UserDatabase.usersCollection.where("type", isEqualTo: "user").where('details.paymentConfirmed', isEqualTo: "true")),
                list(UserDatabase.usersCollection.where("type", isEqualTo: "user").where('details.paymentConfirmed', isEqualTo: "false")),
              ]
          ),
        ),

        SizedBox(
          height: App.screenHeight * 0.02,
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
  }

  Widget list(Query query){
    return FirestoreListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        query: query.orderBy("number", descending: false),
        pageSize: 10,
        itemBuilder: (context, querySnapshot, index, length) {
          return UserItem(user: User.fromDocumentSnapshot(querySnapshot));
        }
    );
  }
}

class UserHome extends StatelessWidget {
  final BoxConstraints constraints;
  const UserHome({Key? key, required this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final width = constraints.maxWidth;

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
              Expanded(
                child: GetX<UserController>(
                    builder: (controller) {

                      final user = controller.user.value;
                      double progress = user.getRegistrationProgress();

                      bool isRegistered = progress == 1;

                      if(isRegistered) {
                        return viewCalendar(width);
                      } else {
                        return completeRegistration(width);
                      }
                    }
                ),
              ),

              SizedBox(width: width * 0.05),

              Expanded(child: viewQR(width))
            ],
          ),
          smallScreen: Column(
            children: [
              GetX<UserController>(
                builder: (controller) {

                  final user = controller.user.value;
                  double progress = user.getRegistrationProgress();

                  bool isRegistered = progress == 1;

                  if(isRegistered) {
                    return viewCalendar(width);
                  } else {
                    return completeRegistration(width);
                  }
                }
              ),

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
                        ? 7 : ResponsiveWidget.isSmallScreen()
                        ? 6 : ResponsiveWidget.isMediumScreen()
                        ? 5 : 4,
                    child: Container(
                      height: Constants.screenHeight * 0.07,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.0275
                      ),
                      child: GetX<UserController>(
                          builder: (controller) {
                            String number = controller.user.value.number.toString();

                            if(number.length == 1){
                              number = "00$number";
                            } else if(number.length == 2){
                              number = "0$number";
                            }

                            number = "ARC$number";
                            return CustomText(
                                number,
                                style: TextStyles(
                                    color: CustomColors.grey[5]
                                ).textBodyLarge
                            );
                          }
                      ),
                    ),

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

  Widget viewCalendar(double width) {
    return completeRegistration(width);
    //TODO
    return Container(
        height: ResponsiveWidget.isExtraSmallScreen()
            ? App.screenHeight * .18: ResponsiveWidget.isSmallScreen()
            ? App.screenHeight * .16 : ResponsiveWidget.isMediumScreen()
            ? App.screenHeight * .15 : App.screenHeight * .18,
        width: width,
        decoration: BoxDecoration(
            color: CustomColors.secondaryPink[3],
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
            Get.toNamed(calendarRoute);
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
                      unselectedColor: CustomColors.secondaryPink[2],
                      selectedColor: CustomColors.secondaryPink,
                      currentStep: 10,
                      child: Center(
                        child: CustomText(
                            "${DateTime.now().day}",
                            style: TextStyle(
                                fontFamily: "TomatoGrotesk",
                                fontSize: ResponsiveWidget.isLargeScreen()
                                    ? constraints.maxHeight * 0.64 * 0.26 : ResponsiveWidget.isMediumScreen()
                                    ? constraints.maxHeight * 0.64 * 0.25 : ResponsiveWidget.isSmallScreen()
                                    ? constraints.maxHeight * 0.64 * 0.24 : constraints.maxHeight * 0.64 * 0.20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.1,
                                color: CustomColors.secondaryPink
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
                            "View Calendar",
                            style: TextStyle(
                                fontFamily: "TomatoGrotesk",
                                fontSize: ResponsiveWidget.isLargeScreen()
                                    ? constraints.maxHeight * 0.64 * 0.26 : ResponsiveWidget.isMediumScreen()
                                    ? constraints.maxHeight * 0.64 * 0.25 : ResponsiveWidget.isSmallScreen()
                                    ? constraints.maxHeight * 0.64 * 0.24 : constraints.maxHeight * 0.64 * 0.20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.1,
                                color: CustomColors.secondaryPink
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
                                color: CustomColors.secondaryPink[2]
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
