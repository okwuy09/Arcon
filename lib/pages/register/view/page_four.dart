import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageFour extends StatelessWidget {
  const PageFour ({Key? key}) : super(key: key);

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
                      question: "How do you plan on attending the dinner on 14th?",
                      values: const ["Virtually", "In person"],
                      splitColumn: true,
                      selectedValue: controller.dinner.value,
                      hasError: controller.dinnerError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.dinner.value = value;
                      },
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "How do you plan on attending the conference?",
                      values: const ["Virtually", "In person"],
                      splitColumn: true,
                      selectedValue: controller.attending.value,
                      hasError: controller.attendingError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.attending.value = value;
                      },
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "Have you made reservations for your accommodation?",
                      values: const ["Yes", "No"],
                      splitColumn: true,
                      selectedValue: controller.reservations.value,
                      hasError: controller.reservationsError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.reservations.value = value;
                      },
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "Would you like assistance with sorting this out?"
                          " Our assistants will contact you or you can send a WhatsApp message to +234 916 783 1106",
                      values: const ["Yes", "No"],
                      splitColumn: true,
                      selectedValue: controller.assistance.value,
                      hasError: controller.assistanceError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.assistance.value = value;
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
