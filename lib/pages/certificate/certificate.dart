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

class Certificate extends StatefulWidget {
  Certificate({Key? key}) : super(key: key){
    Get.put(CertificateController());
  }

  @override
  State<Certificate> createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {

  final bucket = PageStorageBucket();

  final List<Widget> screens = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      syncInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<CertificateController>();

    final experience = TextEditingController();
    experience.text = controller.experience.value;
    final highlights = TextEditingController();
    highlights.text = controller.highlights.value;
    final improvements = TextEditingController();
    improvements.text = controller.improvements.value;
    final seeNext = TextEditingController();
    seeNext.text = controller.seeNext.value;

    return Scaffold(
        backgroundColor: CustomColors.grey[2],
        body: LoadingWrapper(
          child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                return SingleChildScrollView(
                  child: Container(
                    height: App.screenHeight,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.045),
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

                        GetX<CertificateController>(
                            builder: (controller) {

                              if(controller.experience.value != "" && experience.text == ""){
                                experience.text = controller.experience.value;
                              }

                              return CustomTextField(
                                height: Constants.screenHeight * 0.125,
                                controller: experience,
                                labelText: "Overall experience",
                                hintText: "Describe your experience at ARCON 2023",
                                errorText: controller.experienceError
                                    .value == "" ? null : controller
                                    .experienceError.value,
                                onChanged: (value) => controller.experience.value = value,
                                keyboardType: TextInputType.text,
                              );
                            }
                        ),

                        SizedBox(height: Dimen.verticalMarginHeight),

                        GetX<CertificateController>(
                            builder: (controller) {

                              if(controller.highlights.value != "" && highlights.text == ""){
                                highlights.text = controller.highlights.value;
                              }

                              return CustomTextField(
                                height: Constants.screenHeight * 0.125,
                                controller: highlights,
                                labelText: "Highlights and takeouts",
                                hintText: "What were your major highlights/takeouts from ARCON 2023",
                                errorText: controller.highlightsError
                                    .value == "" ? null : controller
                                    .highlightsError.value,
                                onChanged: (value) => controller.highlights.value = value,
                                keyboardType: TextInputType.text,
                              );
                            }
                        ),

                        SizedBox(height: Dimen.verticalMarginHeight),

                        GetX<CertificateController>(
                            builder: (controller) {

                              if(controller.improvements.value != "" && improvements.text == ""){
                                improvements.text = controller.improvements.value;
                              }

                              return CustomTextField(
                                height: Constants.screenHeight * 0.125,
                                controller: improvements,
                                labelText: "Areas of improvement",
                                hintText: "List areas that can be improved on",
                                errorText: controller.improvementsError
                                    .value == "" ? null : controller
                                    .improvementsError.value,
                                onChanged: (value) => controller.improvements.value = value,
                                keyboardType: TextInputType.text,
                              );
                            }
                        ),

                        SizedBox(height: Dimen.verticalMarginHeight),

                        GetX<CertificateController>(
                            builder: (controller) {

                              if(controller.seeNext.value != "" && seeNext.text == ""){
                                seeNext.text = controller.seeNext.value;
                              }

                              return CustomTextField(
                                height: Constants.screenHeight * 0.125,
                                controller: seeNext,
                                labelText: "Future expectations",
                                hintText: "What do you want to see at ARCON 2024",
                                errorText: controller.seeNextError
                                    .value == "" ? null : controller
                                    .seeNextError.value,
                                onChanged: (value) => controller.seeNext.value = value,
                                keyboardType: TextInputType.text,
                              );
                            }
                        ),

                        SizedBox(
                          height: App.screenHeight * 0.025,
                        ),

                        Builder(
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
    controller.highlights.value = user.details["highlights"] ?? "";
    controller.improvements.value = user.details["improvements"] ?? "";
    controller.seeNext.value = user.details["seeNext"] ?? "";
  }

  bool _validateFields(CertificateController controller) {
    if (controller.experience.value.removeAllWhitespace.isEmpty) {
      controller.experienceError.value = "Field cannot be empty";
      return false;
    } else {
      controller.experienceError.value = "";
    }

    if (controller.highlights.value.removeAllWhitespace.isEmpty) {
      controller.highlightsError.value = "Field cannot be empty";
      return false;
    } else {
      controller.highlightsError.value = "";
    }

    if (controller.improvements.value.removeAllWhitespace.isEmpty) {
      controller.improvementsError.value = "Field cannot be empty";
      return false;
    } else {
      controller.improvementsError.value = "";
    }

    if (controller.seeNext.value.removeAllWhitespace.isEmpty) {
      controller.seeNextError.value = "Field cannot be empty";
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
      user.details["highlights"] = controller.highlights.value;
      user.details["improvements"] = controller.improvements.value;
      user.details["seeNext"] = controller.seeNext.value;

      App.startLoading();
      await UserDatabase(user.id).updateUserDetails(user.toJson());
      App.stopLoading();

      final ScreenshotController screenshotController = ScreenshotController();

      App.startLoading();
      await FullCertificate(
        screenshotController: screenshotController,
        userName: controller.user.value.name,
        userEmail: controller.user.value.email,
      ).sendEmail();
      if(Get.find<UserController>().isLoading){
        App.stopLoading();
        Snack.show(message: "Email sent successfully", type: SnackBarType.info);
      }
    }
  }
}