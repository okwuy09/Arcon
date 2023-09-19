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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowUserData extends StatefulWidget {
  const ShowUserData({Key? key}) : super(key: key);

  @override
  State<ShowUserData> createState() => _ShowUserDataState();
}

class _ShowUserDataState extends State<ShowUserData> with TickerProviderStateMixin {

  late TabController tabController;

  User user = User.empty();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      changeActiveIndex(tabController.index);
    });

    changeActiveIndex(0);

    getUser();

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {

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

                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            _PersonalDetails(
                              user: user,
                              constraints: constraints,
                            ),

                            _SurveyResponse(
                              user: user,
                              constraints: constraints,
                            ),

                            _SurveyResponseTwo(
                              user: user,
                              constraints: constraints,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: App.screenHeight * 0.025),

                      Row(
                        children: [

                          Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: Builder(
                                  builder: (context) {
                                    final enable = _activeIndex != 0;
                                    return MaterialButton(
                                      shape: const CircleBorder(),
                                      color: CustomColors.grey[2],
                                      onPressed: () {
                                        if(enable) {
                                          tabController.animateTo(tabController.index - 1);
                                        }
                                      },
                                      elevation: 0,
                                      padding: const EdgeInsets.all(0),
                                      child: Center(
                                        child: RotatedBox(
                                          quarterTurns: 2,
                                          child: Builder(
                                              builder: (context) {
                                                final enable = _activeIndex != 0;
                                                return SVG(
                                                    'assets/icons/right_arrow.svg',
                                                    height: 21,
                                                    width: 21,
                                                    color: enable ? CustomColors.grey[5] : CustomColors.grey[4],
                                                    semanticsLabel: "Back"
                                                );
                                              }
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              )
                          ),

                          const Expanded(child: SizedBox()),

                          Builder(
                              builder: (context) {
                                return buildIndicator(_activeIndex);
                              }
                          ),

                          const Expanded(child: SizedBox()),

                          Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: Builder(
                                  builder: (context) {
                                    final enable = _activeIndex != 2;
                                    return MaterialButton(
                                      shape: const CircleBorder(),
                                      color: CustomColors.grey[2],
                                      onPressed: () {
                                        if(enable) {
                                          tabController.animateTo(tabController.index + 1);
                                        }
                                      },
                                      elevation: 0,
                                      padding: const EdgeInsets.all(0),
                                      child: Center(
                                        child: Builder(
                                            builder: (context) {
                                              final enable = _activeIndex != 2;
                                              return SVG(
                                                  'assets/icons/right_arrow.svg',
                                                  height: 21,
                                                  width: 21,
                                                  color: enable ? CustomColors.grey[5] : CustomColors.grey[4],
                                                  semanticsLabel: "Back"
                                              );
                                            }
                                        ),
                                      ),
                                    );
                                  }
                              )
                          ),

                        ],
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

  void changeActiveIndex(int index) {
    setState(() {
      _activeIndex = index;
    });
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

  Widget buildIndicator(int activeIndex) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: 3,
      duration: const Duration(milliseconds: 500),
      effect: WormEffect(
          dotColor: CustomColors.grey[3]!,
          activeDotColor: CustomColors.primary,
          spacing: 8,
          dotHeight: 8,
          dotWidth: 8,
          radius: 20
      ),
    );
  }

  void getUser() async {
    final userID = Get.currentRoute.split("/").last;

    final mUser = await UserDatabase(userID).getUser(userID) ?? User.empty();

    setState(() {
      user = mUser;
    });
  }
}

class _PersonalDetails extends StatelessWidget {
  final User user;
  final BoxConstraints constraints;
  const _PersonalDetails({Key? key, required this.constraints, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
}

class _SurveyResponse extends StatelessWidget {
  final User user;
  final BoxConstraints constraints;
  const _SurveyResponse({Key? key, required this.constraints, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              title: "Overall experience",
              value: user.details["experience"] ?? "",
            ),

            SizedBox(height: App.screenHeight * 0.015),

            item(
              title: "Highlights and takeouts",
              value: user.details["highlights"] ?? "",
            ),

            SizedBox(height: App.screenHeight * 0.015),

            item(
              title: "Areas of improvement",
              value: user.details["improvements"] ?? "",
            ),
          ],
        )
    );
  }

  Widget item({required String title, required String value, bool isClickable = false}) {

    if(value.contains('/*OPTION*/')){
      final fields = value.split('/*OPTION*/');
      value = "";
      for(String field in fields){
        value = '$value${value.isEmpty ? "" : "\n"}$field';
      }
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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

          SizedBox(
            height: App.screenHeight * 0.01,
            width: double.infinity,
          ),

          Expanded(
            child: CustomText(
                value.isEmpty ? "N/A" : value,
                style: TextStyle(
                    fontFamily: "TomatoGrotesk",
                    fontSize: App.screenHeight * 0.25 * 0.07,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    decoration: isClickable ? TextDecoration.underline : null,
                    color: isClickable ? CustomColors.secondaryBlue : CustomColors.grey[5],
                ),
                textAlign: TextAlign.start,
                maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SurveyResponseTwo extends StatelessWidget {
  final User user;
  final BoxConstraints constraints;
  const _SurveyResponseTwo({Key? key, required this.constraints, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              title: "Recommendations to improve financing",
              value: user.details["recommendations"] ?? "",
            ),

            SizedBox(height: App.screenHeight * 0.015),

            item(
              title: "Takeouts from panel session",
              value: user.details["takeout"] ?? "",
            ),

            SizedBox(height: App.screenHeight * 0.015),

            item(
              title: "Future expectations",
              value: user.details["seeNext"] ?? "",
            ),
          ],
        )
    );
  }

  Widget item({required String title, required String value, bool isClickable = false}) {

    if(value.contains('/*OPTION*/')){
      final fields = value.split('/*OPTION*/');
      value = "";
      for(String field in fields){
        value = '$value${value.isEmpty ? "" : "\n"}$field';
      }
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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

          SizedBox(
            height: App.screenHeight * 0.01,
            width: double.infinity,
          ),

          Expanded(
            child: CustomText(
                value.isEmpty ? "N/A" : value,
                style: TextStyle(
                    fontFamily: "TomatoGrotesk",
                    fontSize: App.screenHeight * 0.25 * 0.07,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    decoration: isClickable ? TextDecoration.underline : null,
                    color: isClickable ? CustomColors.secondaryBlue : CustomColors.grey[5],
                ),
                textAlign: TextAlign.start,
                maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}

