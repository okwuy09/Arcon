import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

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
                      question: "Are you a resident doctor?",
                      values: const ["Yes", "No"],
                      splitColumn: true,
                      selectedValue: controller.resident.value,
                      hasError: controller.residentError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.resident.value = value;
                      },
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "Gender",
                      values: const ["Male", "Female", "Prefer not to say"],
                      splitColumn: true,
                      selectedValue: controller.gender.value,
                      hasError: controller.genderError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.gender.value = value;
                      },
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "Which single area do you identify yourself with the most?",
                      values: const [
                        "Researcher (any and all types)",
                        "Policy/Government",
                        "Clinician",
                        "Advocate",
                        "Patient Advocate/Survivor"
                      ],
                      selectedValue: controller.area.value,
                      hasError: controller.areaError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.area.value = value;
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
