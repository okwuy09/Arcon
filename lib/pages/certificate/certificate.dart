import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/logic/models/models.dart';
import 'package:arcon/pages/certificate/full_certificate.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Certificate extends StatefulWidget {
  Certificate({Key? key}) : super(key: key){
    Get.put(CertificateController());
  }

  @override
  State<Certificate> createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> with TickerProviderStateMixin {

  late TabController tabController;

  final controller = Get.find<CertificateController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      syncInfo();
    });

    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      controller.changeActiveIndex(tabController.index);
    });

    controller.changeActiveIndex(0);

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  final experience = TextEditingController();

  final highlight1 = TextEditingController();
  final highlight2 = TextEditingController();
  final highlight3 = TextEditingController();

  final improvement1 = TextEditingController();
  final improvement2 = TextEditingController();
  final improvement3 = TextEditingController();

  final recommendation1 = TextEditingController();
  final recommendation2 = TextEditingController();
  final recommendation3 = TextEditingController();

  final takeout1 = TextEditingController();
  final takeout2 = TextEditingController();
  final takeout3 = TextEditingController();

  final seeNext1 = TextEditingController();
  final seeNext2 = TextEditingController();
  final seeNext3 = TextEditingController();
  @override
  Widget build(BuildContext context) {

    syncControllers(controller);

    return Scaffold(
        backgroundColor: CustomColors.grey[2],
        body: LoadingWrapper(
          child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                return SingleChildScrollView(
                  child: Container(
                    height: App.screenHeight,
                    margin: EdgeInsets.fromLTRB(
                      width * 0.035,
                      App.screenHeight * 0.04,
                      width * 0.035,
                      ResponsiveWidget.isExtraSmallScreen()
                          ? App.screenHeight * 0.01 : App.screenHeight * 0.03,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(12)
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [

                        SizedBox(
                          height: App.screenHeight * 0.045,
                        ),

                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    GetX<CertificateController>(
                                        builder: (controller) {
                                          return item(
                                            controllers: [experience],
                                            obx: [controller.experience],
                                            error: controller.experienceError.value,
                                            isList: false,
                                            labelText: "Overall experience",
                                            hintText: "Describe your experience at ARCON 2023",
                                          );
                                        }
                                    ),

                                    SizedBox(height: Dimen.verticalMarginHeight),

                                    GetX<CertificateController>(
                                        builder: (controller) {
                                          return item(
                                            controllers: [
                                              highlight1,
                                              highlight2,
                                              highlight3,
                                            ],
                                            obx: [
                                              controller.highlight1,
                                              controller.highlight2,
                                              controller.highlight3,
                                            ],
                                            error: controller.highlightsError.value,
                                            isList: true,
                                            labelText: "List 3 of your major highlights/takeouts from ARCON 2023",
                                            hintText: "Highlight 1/Highlight 2/Highlight 3",
                                          );
                                        }
                                    ),

                                  ],
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [

                                    GetX<CertificateController>(
                                        builder: (controller) {
                                          return item(
                                            controllers: [
                                              improvement1,
                                              improvement2,
                                              improvement3,
                                            ],
                                            obx: [
                                              controller.improvement1,
                                              controller.improvement2,
                                              controller.improvement3,
                                            ],
                                            error: controller.improvementsError.value,
                                            isList: true,
                                            labelText: "List 3 areas that can be improved on",
                                            hintText: "Improvement 1/Improvement 2/Improvement 3",
                                          );
                                        }
                                    ),

                                    SizedBox(height: Dimen.verticalMarginHeight),

                                    GetX<CertificateController>(
                                        builder: (controller) {
                                          return item(
                                            controllers: [
                                              recommendation1,
                                              recommendation2,
                                              recommendation3,
                                            ],
                                            obx: [
                                              controller.recommendation1,
                                              controller.recommendation2,
                                              controller.recommendation3,
                                            ],
                                            error: controller.recommendationsError.value,
                                            isList: true,
                                            labelText: "List 3 recommendations to improve healthcare financing in Oncology in Nigeria",
                                            hintText: "Recommendation 1/Recommendation 2/Recommendation 3",
                                          );
                                        }
                                    ),

                                  ],
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [

                                    GetX<CertificateController>(
                                        builder: (controller) {
                                          return item(
                                            controllers: [
                                              takeout1,
                                              takeout2,
                                              takeout3,
                                            ],
                                            obx: [
                                              controller.takeout1,
                                              controller.takeout2,
                                              controller.takeout3,
                                            ],
                                            error: controller.takeoutError.value,
                                            isList: true,
                                            labelText: "List 3 major takeouts from Healthcare Financing panel session",
                                            hintText: "Takeout 1/Takeout 2/Takeout 3",
                                          );
                                        }
                                    ),

                                    SizedBox(height: Dimen.verticalMarginHeight),

                                    GetX<CertificateController>(
                                        builder: (controller) {
                                          return item(
                                            controllers: [
                                              seeNext1,
                                              seeNext2,
                                              seeNext3,
                                            ],
                                            obx: [
                                              controller.seeNext1,
                                              controller.seeNext2,
                                              controller.seeNext3,
                                            ],
                                            error: controller.seeNextError.value,
                                            isList: true,
                                            labelText: "List 3 things you want to see at ARCON 2024",
                                            hintText: "Expectations 1/Expectations 2/Expectations 3",
                                          );
                                        }
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                        SizedBox(
                          height: App.screenHeight * 0.025,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                          child: Row(
                            children: [

                              Container(
                                  width: 42,
                                  height: 42,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                                  child: GetX<CertificateController>(
                                      builder: (controller) {
                                        final enable = controller.activeIndex != 0;
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
                                              child: GetX<CertificateController>(
                                                  builder: (controller) {
                                                    final enable = controller.activeIndex != 0;
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

                              GetX<CertificateController>(
                                  builder: (controller) {
                                    return buildIndicator(controller.activeIndex);
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
                                  child: GetX<CertificateController>(
                                      builder: (controller) {
                                        final enable = controller.activeIndex != 2;
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
                                            child: GetX<CertificateController>(
                                                builder: (controller) {
                                                  final enable = controller.activeIndex != 2;
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
                        ),

                        SizedBox(
                          height: App.screenHeight * 0.025,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                          child: Builder(
                              builder: (context) {
                                final returnButton = CustomButton(
                                    text: "RETURN",
                                    borderColor: CustomColors.primary,
                                    color: Colors.white,
                                    textColor: CustomColors.primary,
                                    onPressed: () {
                                      Get.back();
                                    }
                                );

                                final horizontalSpacing = SizedBox(width: width * 0.05);

                                final verticalSpacing = SizedBox(height: App.screenHeight * 0.025);

                                final getButton = CustomButton(
                                    text: "GET CERTIFICATE",
                                    color: CustomColors.primary,
                                    onPressed: () {
                                      getCertificate(controller);
                                    }
                                );

                                return ResponsiveWidget(
                                    largeScreen: Row(
                                      children: [
                                        Expanded(child: returnButton),

                                        horizontalSpacing,

                                        Expanded(child: getButton)
                                      ],
                                    ),
                                    mediumScreen: Row(
                                      children: [
                                        Expanded(child: returnButton),

                                        horizontalSpacing,

                                        Expanded(child: getButton)
                                      ],
                                    ),
                                    smallScreen: Column(
                                      children: [

                                        getButton,

                                        verticalSpacing,

                                        returnButton
                                      ],
                                    )
                                );
                              }
                          ),
                        ),

                        SizedBox(
                          height: ResponsiveWidget.isExtraSmallScreen()
                              ? App.screenHeight * 0.015 : App.screenHeight * 0.02,
                        ),
                      ],

                    ),
                  ),
                );
              }
          ),
        )
    );
  }

  void syncInfo() async {

    final controller = Get.find<CertificateController>();

    controller.user.value = await UserDatabase(Auth().uID).getUser(Auth().uID) ?? User.empty();
    final user = controller.user.value;

    controller.experience.value = user.details["experience"] ?? "";

    final highlights = (user.details["highlights"] ?? "").split('/*OPTION*/');
    if(highlights.length > 0) controller.highlight1.value = highlights[0];
    if(highlights.length > 1) controller.highlight2.value = highlights[1];
    if(highlights.length > 2) controller.highlight3.value = highlights[2];

    final improvements = (user.details["improvements"] ?? "").split('/*OPTION*/');
    if(improvements.length > 0) controller.improvement1.value = improvements[0];
    if(improvements.length > 1) controller.improvement2.value = improvements[1];
    if(improvements.length > 2) controller.improvement3.value = improvements[2];

    final recommendations = (user.details["recommendations"] ?? "").split('/*OPTION*/');
    if(recommendations.length > 0) controller.recommendation1.value = recommendations[0];
    if(recommendations.length > 1) controller.recommendation2.value = recommendations[1];
    if(recommendations.length > 2) controller.recommendation3.value = recommendations[2];

    final takeout = (user.details["takeout"] ?? "").split('/*OPTION*/');
    if(takeout.length > 0) controller.takeout1.value = takeout[0];
    if(takeout.length > 1) controller.takeout2.value = takeout[1];
    if(takeout.length > 2) controller.takeout3.value = takeout[2];

    final seeNext = (user.details["seeNext"] ?? "").split('/*OPTION*/');
    if(seeNext.length > 0) controller.seeNext1.value = seeNext[0];
    if(seeNext.length > 1) controller.seeNext2.value = seeNext[1];
    if(seeNext.length > 2) controller.seeNext3.value = seeNext[2];
  }

  bool _validateFields(CertificateController controller) {
    if (controller.experience.value.removeAllWhitespace.isEmpty) {
      controller.experienceError.value = "Field cannot be empty";
      tabController.animateTo(0);
      return false;
    } else {
      controller.experienceError.value = "";
    }

    if (controller.highlight1.value.removeAllWhitespace.isEmpty
        || controller.highlight2.value.removeAllWhitespace.isEmpty
        || controller.highlight3.value.removeAllWhitespace.isEmpty) {
      controller.highlightsError.value = "Fields cannot be empty";
      tabController.animateTo(0);
      return false;
    } else {
      controller.highlightsError.value = "";
    }

    if (controller.improvement1.value.removeAllWhitespace.isEmpty
        || controller.improvement2.value.removeAllWhitespace.isEmpty
        || controller.improvement3.value.removeAllWhitespace.isEmpty) {
      controller.improvementsError.value = "Fields cannot be empty";
      tabController.animateTo(1);
      return false;
    } else {
      controller.improvementsError.value = "";
    }

    if (controller.recommendation1.value.removeAllWhitespace.isEmpty
        || controller.recommendation2.value.removeAllWhitespace.isEmpty
        || controller.recommendation3.value.removeAllWhitespace.isEmpty) {
      controller.recommendationsError.value = "Fields cannot be empty";
      tabController.animateTo(1);
      return false;
    } else {
      controller.recommendationsError.value = "";
    }

    if (controller.takeout1.value.removeAllWhitespace.isEmpty
        || controller.takeout2.value.removeAllWhitespace.isEmpty
        || controller.takeout3.value.removeAllWhitespace.isEmpty) {
      controller.takeoutError.value = "Fields cannot be empty";
      tabController.animateTo(2);
      return false;
    } else {
      controller.takeoutError.value = "";
    }

    if (controller.seeNext1.value.removeAllWhitespace.isEmpty
        || controller.seeNext2.value.removeAllWhitespace.isEmpty
        || controller.seeNext3.value.removeAllWhitespace.isEmpty) {
      controller.seeNextError.value = "Fields cannot be empty";
      tabController.animateTo(2);
      return false;
    } else {
      controller.seeNextError.value = "";
    }

    return true;
  }

  void getCertificate(CertificateController controller) async {
    if(_validateFields(controller)){

      final user = controller.user.value;

      user.details["experience"] = controller.experience.value;
      const divider = '/*OPTION*/';
      user.details["highlights"] = controller.highlight1.value + divider + controller.highlight2.value + divider + controller.highlight3.value;
      user.details["improvements"] = controller.improvement1.value + divider + controller.improvement2.value + divider + controller.improvement3.value;
      user.details["recommendations"] = controller.recommendation1.value + divider + controller.recommendation2.value + divider + controller.recommendation3.value;
      user.details["takeout"] = controller.takeout1.value + divider + controller.takeout2.value + divider + controller.takeout3.value;
      user.details["seeNext"] = controller.seeNext1.value + divider + controller.seeNext2.value + divider + controller.seeNext3.value;

      App.startLoading();
      await UserDatabase(user.id).updateUserDetails(user.toJson());
      App.stopLoading();

      final ScreenshotController screenshotController = ScreenshotController();

      App.startLoading();
      await FullCertificate(
        screenshotController: screenshotController,
        userName: controller.user.value.name,
        userEmail: controller.user.value.email,
      ).download();
      App.stopLoading();
    }
  }

  Widget item({
    required List<TextEditingController> controllers,
    required List<RxString> obx,
    required String error,
    required bool isList,
    required String labelText,
    required String hintText
  }) {

    final TextEditingController firstController = controllers[0];
    TextEditingController secondController = TextEditingController();
    TextEditingController thirdController = TextEditingController();

    final firstObx = obx[0];
    RxString secondObx = "".obs;
    RxString thirdObx = "".obs;

    if(isList){
      secondObx = obx[1];
      thirdObx = obx[2];

      secondController = controllers[1];
      thirdController = controllers[2];

      if(firstObx.value != "" && firstController.text == ""){
        firstController.text = firstObx.value;
      }

      if(secondObx.value != "" && secondController.text == ""){
        secondController.text = secondObx.value;
      }

      if(thirdObx.value != "" && thirdController.text == ""){
        thirdController.text = thirdObx.value;
      }

    } else {
      if(firstObx.value != "" && firstController.text == ""){
        firstController.text = firstObx.value;
      }
    }

    return Builder(
      builder: (context) {
        if(isList){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  labelText,
                  style: TextStyles(
                      color: CustomColors.grey[5],
                      letterSpacing: 0
                  ).textSubtitleLarge,
                  textAlign: TextAlign.start,
                  maxLines: 4,
              ),

              const SizedBox(height: Constants.screenHeight * 0.0125),

              CustomTextField(
                height: Constants.screenHeight * 0.06,
                controller: firstController,
                hideLabel: true,
                hideError: true,
                hintText: hintText.split('/')[0],
                errorText: error == "" ? null : error,
                onChanged: (value) => firstObx.value = value,
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: Constants.screenHeight * 0.0125),

              CustomTextField(
                height: Constants.screenHeight * 0.06,
                controller: secondController,
                hideLabel: true,
                hideError: true,
                hintText: hintText.split('/')[1],
                errorText: error == "" ? null : error,
                onChanged: (value) => secondObx.value = value,
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: Constants.screenHeight * 0.0125),

              CustomTextField(
                height: Constants.screenHeight * 0.06,
                controller: thirdController,
                hideLabel: true,
                hideError: true,
                hintText: hintText.split('/')[2],
                errorText: error == "" ? null : error,
                onChanged: (value) => thirdObx.value = value,
                keyboardType: TextInputType.text,
              ),

              if(error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: Constants.screenHeight * 0.0125,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                          error,
                          style: error.length > 42
                              ? TextStyles(
                              color: CustomColors.error
                          ).textBodySmall
                              : TextStyles(
                              color: CustomColors.error
                          ).textBodyMedium
                      ),
                    ],
                  ),
                )

            ],
          );
        } else {
          return CustomTextField(
            height: Constants.screenHeight * 0.12,
            controller: firstController,
            labelText: labelText,
            hintText: hintText,
            errorText: error == "" ? null : error,
            onChanged: (value) => firstObx.value = value,
            keyboardType: TextInputType.text,
          );
        }
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

  void syncControllers(CertificateController controller) {

    experience.text = controller.experience.value;

    highlight1.text = controller.highlight1.value;
    highlight2.text = controller.highlight2.value;
    highlight3.text = controller.highlight3.value;

    improvement1.text = controller.improvement1.value;
    improvement2.text = controller.improvement2.value;
    improvement3.text = controller.improvement3.value;

    recommendation1.text = controller.recommendation1.value;
    recommendation2.text = controller.recommendation2.value;
    recommendation3.text = controller.recommendation3.value;

    takeout1.text = controller.takeout1.value;
    takeout2.text = controller.takeout2.value;
    takeout3.text = controller.takeout3.value;

    seeNext1.text = controller.seeNext1.value;
    seeNext2.text = controller.seeNext2.value;
    seeNext3.text = controller.seeNext3.value;
  }
}