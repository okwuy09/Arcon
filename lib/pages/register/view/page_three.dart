import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return LayoutBuilder(
        builder: (context, constraints) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "Are you a speaker in ARCON 2023?",
                      values: const ["Yes", "No"],
                      splitColumn: true,
                      selectedValue: controller.speaker.value,
                      hasError: controller.speakerError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.speaker.value = value;
                      },
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "Would you like to register to attend the workshop"
                          " focused on Psycho-oncology during the conference?",
                      values: const ["Yes", "No"],
                      splitColumn: true,
                      selectedValue: controller.psychoOncology.value,
                      hasError: controller.psychoOncologyError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.psychoOncology.value = value;
                      },
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "Would you like to register to attend the workshop "
                          "focused on Breaking Bad News during the conference?",
                      values: const ["Yes", "No"],
                      splitColumn: true,
                      selectedValue: controller.badNews.value,
                      hasError: controller.badNewsError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.badNews.value = value;
                      },
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "Would you like to register to attend the workshop"
                          " focused on Brachytherapy during the conference?",
                      values: const ["Yes", "No"],
                      splitColumn: true,
                      selectedValue: controller.brachytherapy.value,
                      hasError: controller.brachytherapyError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.brachytherapy.value = value;
                      },
                    );
                  }
              ),

            ],
          );
        }
    );
  }
}
