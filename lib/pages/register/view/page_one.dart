import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<RegistrationController>();

    final phoneNumber = TextEditingController();
    phoneNumber.text = controller.phoneNumber.value;
    final institution = TextEditingController();
    institution.text = controller.institution.value;
    final otherCredential = TextEditingController();
    otherCredential.text = controller.otherCredential.value;

    return LayoutBuilder(
        builder: (context, constraints) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetX<RegistrationController>(
                  builder: (controller) {

                    if(controller.phoneNumber.value != "" && phoneNumber.text == ""){
                      phoneNumber.text = controller.phoneNumber.value;
                    }
                    return CustomTextField(
                      height: Constants.screenHeight * 0.06,
                      controller: phoneNumber,
                      labelText: "Phone Number",
                      hintText: "Enter your phone number",
                      errorText: controller.phoneNumberError
                          .value == "" ? null : controller
                          .phoneNumberError.value,
                      onChanged: (value) => controller.phoneNumber.value = value,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"\d")),
                      ],
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {

                    if(controller.institution.value != "" && institution.text == ""){
                      institution.text = controller.institution.value;
                    }
                    return CustomTextField(
                      height: Constants.screenHeight * 0.06,
                      controller: institution,
                      labelText: "Name of institution",
                      hintText: "Name of institution you are currently employed or affiliated with",
                      errorText: controller.institutionError
                          .value == "" ? null : controller
                          .institutionError.value,
                      onChanged: (value) => controller.institution.value = value,
                      keyboardType: TextInputType.text,
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              GetX<RegistrationController>(
                  builder: (controller) {
                    return QuestionWidget(
                      question: "Please specify your credentials or degree",
                      values: const [
                        "MBBS",
                        "Specialist/Consultant",
                        "Phd",
                        "BSc",
                        "MSc",
                        "RN",
                        "Other"
                      ],
                      splitColumn: true,
                      selectedValue: controller.credentials.value,
                      hasError: controller.credentialsError.value != "",
                      onValueChanged: (value) {
                        value ??= "";
                        controller.credentials.value = value;
                      },
                    );
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight * 0.5),

              GetX<RegistrationController>(
                  builder: (controller) {

                    if(controller.otherCredential.value != "" && otherCredential.text == ""){
                      otherCredential.text = controller.otherCredential.value;
                    }

                    if(controller.credentials.value != "Other") return const SizedBox();

                    return CustomTextField(
                      height: Constants.screenHeight * 0.06,
                      controller: otherCredential,
                      labelText: "Specify Other",
                      hintText: "Specify other credential you possess",
                      errorText: controller.otherCredentialError
                          .value == "" ? null : controller
                          .otherCredentialError.value,
                      onChanged: (value) => controller.otherCredential.value = value,
                      keyboardType: TextInputType.text,
                    );
                  }
              ),

            ],
          );
        }
    );
  }
}
