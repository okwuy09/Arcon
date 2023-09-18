import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/register/register.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:arcon/services/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key){
    Get.put(RegistrationController());
  }

  @override
  Widget build(BuildContext context) {
    return const _Default();
  }

  static Widget progressWidget(){
    final controller = Get.find<RegistrationController>();

    final tabLength = controller.tabLength;

    final totalItems = (tabLength * 2) + (tabLength - 3);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
          totalItems + 1,
          (index) {
            switch (index % 3) {
              case 0:
                return circle("${(index ~/ 3) + 1}", (index ~/ 3));
              case 1:
                return rod((index ~/ 3));
              case 2:
                return rod((index ~/ 3) + 1);
            }

            return const SizedBox();
          }),
    );
  }

  static Widget rod(int index){
    return Expanded(
      child: GetX<RegistrationController>(
          builder: (controller) {
            return AnimatedContainer(
                height: 2,
                width: double.infinity,
                duration: const Duration(milliseconds: 400),
                color: controller.currentTab.value >= index ? CustomColors.primary : CustomColors.grey[5]
            );
          }
      ),
    );
  }

  static Widget circle(String text, int index){
    return GetX<RegistrationController>(
        builder: (controller) {
          return AnimatedContainer(
            height: App.screenHeight * 0.06,
            width: App.screenHeight * 0.06,
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.currentTab.value >= index ? CustomColors.primary : CustomColors.grey[5]
            ),
            child: MaterialButton(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              onPressed: () {
                controller.changeTab(index);
              },
              child: Center(
                child:  GetX<RegistrationController>(
                    builder: (controller) {
                      return CustomText(
                        text,
                        style: TextStyles(
                            color: controller.currentTab.value >= index ? CustomColors.grey : CustomColors.grey[3]
                        ).displayBodySmall,
                      );
                    }
                ),
              ),
            ),
          );

        }
    );
  }
}

class _Default extends StatefulWidget {
  const _Default({Key? key}) : super(key: key);

  @override
  State<_Default> createState() => _DefaultState();
}

class _DefaultState extends State<_Default> {
  final bucket = PageStorageBucket();

  final List<Widget> screens = [
    const PageOne(),
    const PageTwo(),
    const PageThree(),
    const PageFour(),
    const PageFive(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      syncInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

                      Register.progressWidget(),

                      SizedBox(
                        height: App.screenHeight * 0.025,
                      ),

                      SizedBox(
                        height:  ResponsiveWidget.isExtraSmallScreen()
                            ? App.screenHeight * 0.615 : App.screenHeight * 0.6,
                        width: width,
                        child: GetX<RegistrationController>(
                            builder: (controller) {
                              return PageStorage(
                                  bucket: bucket,
                                  child: screens[controller.currentTab.value]
                              );
                            }),
                      ),

                      SizedBox(
                        height: App.screenHeight * 0.025,
                      ),

                      Builder(
                        builder: (context) {
                          final previousButton =  GetX<RegistrationController>(
                            builder: (controller) {
                              final isFirstTab = controller.currentTab.value == 0;
                              return CustomButton(
                                  text: isFirstTab ? "RETURN" : "PREVIOUS",
                                  borderColor: CustomColors.primary,
                                  color: Colors.white,
                                  textColor: CustomColors.primary,
                                  onPressed: () {
                                    if(isFirstTab){
                                      Get.back();
                                    } else {
                                      controller.changeTab(controller.currentTab.value - 1);
                                    }
                                  }
                              );
                            }
                          );

                          final horizontalSpacing = SizedBox(width: width * 0.05);

                          final verticalSpacing = SizedBox(height: App.screenHeight * 0.025);

                          final continueButton = GetX<RegistrationController>(
                            builder: (controller) {
                              final isLastTab = controller.currentTab.value == controller.tabLength - 1;

                              return CustomButton(
                                  text: isLastTab ? "FINISH" : "SAVE & CONTINUE",
                                  color: isLastTab
                                      ? controller.hasFinished.value
                                        ? CustomColors.primary : CustomColors.grey[4]
                                      : CustomColors.primary,
                                  onPressed: () async {
                                    if(controller.currentTab.value < controller.tabLength - 1) {
                                      save(controller);
                                    } else {
                                      if(controller.hasFinished.value){
                                        if(controller.proofImage.isNotEmpty){
                                          uploadProof(controller);
                                        }
                                      }
                                    }
                                  }
                              );
                            }
                          );

                          return ResponsiveWidget(
                              largeScreen: Row(
                                children: [
                                  Expanded(child: previousButton),

                                  horizontalSpacing,

                                  Expanded(child: continueButton)
                                ],
                              ),
                              mediumScreen: Row(
                                children: [
                                  Expanded(child: previousButton),

                                  horizontalSpacing,

                                  Expanded(child: continueButton)
                                ],
                              ),
                              smallScreen: Column(
                                children: [

                                  continueButton,

                                  verticalSpacing,

                                  previousButton
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

  void syncInfo() {

    final controller = Get.find<RegistrationController>();

    final userController = Get.find<UserController>();

    final user = userController.user.value;

    controller.phoneNumber.value = user.phoneNumber;
    controller.gender.value = user.gender;
    controller.institution.value = user.institution;
    controller.credentials.value = user.credentials;
    final isOtherCredential = controller.credentials.value.contains("Other (");
    if(isOtherCredential){
      final field = controller.credentials.value.split("Other (")[1];
      controller.otherCredential.value = field.substring(0, field.length - 1);
      controller.credentials.value = "Other";
    }

    controller.resident.value = user.details["resident"];
    controller.area.value = user.details["area"];
    controller.speaker.value = user.details["speaker"];
    controller.attending.value = user.details["attending"];
    controller.dinner.value = user.details["dinner"];
    controller.reservations.value = user.details["reservations"];
    controller.assistance.value = user.details["assistance"];
    controller.psychoOncology.value = user.details["psychoOncology"];
    controller.badNews.value = user.details["badNews"];
    controller.brachytherapy.value = user.details["brachytherapy"];
    controller.hasFinished.value = user.details["hasFinished"] == "true";
    controller.paymentSubmitted.value = user.details["paymentSubmitted"] == "true";
    controller.paymentConfirmed.value = user.details["paymentConfirmed"] == "true";
  }

  void save(RegistrationController controller) async {
    if(_validateFields(controller)){

      final user = Get.find<UserController>().user.value;

      switch(controller.currentTab.value){
        case 0:
          user.phoneNumber = controller.phoneNumber.value.removeAllWhitespace;
          user.institution = controller.institution.value;
          user.credentials = controller.credentials.value;

          if(user.credentials == "Other") {
            user.credentials = "Other (${controller.otherCredential.value})";
          }
          break;
        case 1:
          user.details["resident"] = controller.resident.value;
          user.gender = controller.gender.value;
          user.details["area"] = controller.area.value;
          break;
        case 2:
          user.details["speaker"] = controller.speaker.value;
          user.details["psychoOncology"] = controller.psychoOncology.value;
          user.details["badNews"] = controller.badNews.value;
          user.details["brachytherapy"] = controller.brachytherapy.value;
          break;
        case 3:
          user.details["attending"] = controller.attending.value;
          user.details["dinner"] = controller.dinner.value;
          user.details["reservations"] = controller.reservations.value;
          user.details["assistance"] = controller.assistance.value;
          break;
      }

      App.startLoading();
      await UserDatabase(user.id).updateUserDetails(user.toJson());
      App.stopLoading();

      controller.changeTab(controller.currentTab.value + 1);
    }
  }

  bool _validateFields(RegistrationController controller) {
    switch(controller.currentTab.value){
      case 0:
        if (controller.phoneNumber.value.removeAllWhitespace.length < 11) {
          controller.phoneNumberError.value = "Please input a 11-digit number";
          return false;
        } else {
          controller.phoneNumberError.value = "";
        }

        if (controller.institution.value.removeAllWhitespace.isEmpty) {
          controller.institutionError.value = "Please input your institution";
          return false;
        } else {
          controller.institutionError.value = "";
        }

        if (controller.credentials.value.removeAllWhitespace.isEmpty) {
          controller.credentialsError.value = "Please select your credential";
          return false;
        } else {
          controller.credentialsError.value = "";
        }

        if (controller.credentials.value.removeAllWhitespace == "Other"
          && controller.otherCredential.value.removeAllWhitespace.isEmpty) {
          controller.otherCredentialError.value = "Please specify other credential";
          return false;
        } else {
          controller.otherCredentialError.value = "";
        }

        break;
      case 1:
        if (controller.resident.value.removeAllWhitespace.isEmpty) {
          controller.residentError.value = "Please select an option";
          return false;
        } else {
          controller.residentError.value = "";
        }

        if (controller.gender.value.removeAllWhitespace.isEmpty) {
          controller.genderError.value = "Please select an option";
          return false;
        } else {
          controller.genderError.value = "";
        }

        if (controller.area.value.removeAllWhitespace.isEmpty) {
          controller.areaError.value = "Please select an option";
          return false;
        } else {
          controller.areaError.value = "";
        }
        break;
      case 2:
        if (controller.speaker.value.removeAllWhitespace.isEmpty) {
          controller.speakerError.value = "Please select an option";
          return false;
        } else {
          controller.speakerError.value = "";
        }

        if (controller.psychoOncology.value.removeAllWhitespace.isEmpty) {
          controller.psychoOncologyError.value = "Please select an option";
          return false;
        } else {
          controller.psychoOncologyError.value = "";
        }

        if (controller.badNews.value.removeAllWhitespace.isEmpty) {
          controller.badNewsError.value = "Please select an option";
          return false;
        } else {
          controller.badNewsError.value = "";
        }

        if (controller.brachytherapy.value.removeAllWhitespace.isEmpty) {
          controller.brachytherapyError.value = "Please select an option";
          return false;
        } else {
          controller.brachytherapyError.value = "";
        }
        break;
      case 3:
        if (controller.dinner.value.removeAllWhitespace.isEmpty) {
          controller.dinnerError.value = "Please select an option";
          return false;
        } else {
          controller.dinnerError.value = "";
        }

        if (controller.attending.value.removeAllWhitespace.isEmpty) {
          controller.attendingError.value = "Please select an option";
          return false;
        } else {
          controller.attendingError.value = "";
        }

        if (controller.reservations.value.removeAllWhitespace.isEmpty) {
          controller.reservationsError.value = "Please select an option";
          return false;
        } else {
          controller.reservationsError.value = "";
        }

        if (controller.assistance.value.removeAllWhitespace.isEmpty) {
          controller.assistanceError.value = "Please select an option";
          return false;
        } else {
          controller.assistanceError.value = "";
        }
        break;
      case 4:
        if(!controller.paymentSubmitted.value || !controller.paymentConfirmed.value){
          Snack.show(
              message: "Your payment has to be confirmed before you can complete"
                  " your registration",
              type: SnackBarType.error
          );
          return false;
        }
    }

    return true;
  }

  Future<void> uploadProof(RegistrationController controller) async {
    final user = Get.find<UserController>().user.value;

    String destination = 'payment_proofs/';

    UploadTask? task = Storage().uploadImage(destination, "${user.id}_", controller.rawProofImage.value!);

    if(task == null) {
      Snack.show(message: "Could not upload payment proof", type: SnackBarType.error);
      return;
    }

    App.startLoading();

    final snapshot = await task.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();

    user.details["paymentProof"] = imageUrl;
    user.details["paymentSubmitted"] = "true";

    await UserDatabase(user.id).updateUserDetails(user.toJson());

    App.stopLoading();

    Get.back();

    Snack.show(
        message: "Your payment is being verified, check back later for your QR",
        length: 1,
        type: SnackBarType.success
    );
  }
}
