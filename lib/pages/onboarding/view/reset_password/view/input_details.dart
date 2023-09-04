 import 'package:arcon/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';

class InputDetails extends StatelessWidget {
  const InputDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController email =  TextEditingController();

    final controller = Get.find<ResetPasswordController>();

    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Expanded(flex: 1, child: SizedBox()),

          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              "Reset your account password",
              style: TextStyles(
                color: CustomColors.grey[5],
              ).displayTitleLarge,
              maxLines: 2,
              textAlign: TextAlign.start,
            ),
          ),

          SizedBox(height: Dimen.verticalMarginHeight),

          SizedBox(
            width: double.infinity,
            child: CustomText(
              "Enter your account email address to reset your password",
              style: TextStyles(
                color: CustomColors.grey[5],
              ).textBodyLarge,
              maxLines: 2,
              textAlign: TextAlign.start,
            ),
          ),

          SizedBox(height: Dimen.verticalMarginHeight * 3),

          GetX<ResetPasswordController>(
              builder: (controller) {

                if(controller.emailAddress.value != "" && email.text == ""){
                  email.text = controller.emailAddress.value;
                }
                return CustomTextField(
                  height: Constants.screenHeight * 0.06,
                  controller: email,
                  labelText: "Email",
                  hintText: "Enter your email address",
                  errorText: controller.emailAddressError
                      .value == "" ? null : controller
                      .emailAddressError.value,
                  onChanged: (value) => controller.emailAddress.value = value,
                  keyboardType: TextInputType.emailAddress,
                );
              }
          ),

          const Expanded(flex: 3, child: SizedBox()),

          CustomButton(
            text: "Reset Password",
            onPressed: () {
              _resetPassword(controller);
            },
          ),

          SizedBox(height: Dimen.verticalMarginHeight * 2),

        ],
      ),
    );
  }

  _resetPassword(ResetPasswordController controller) async {
    if(_validateFields(controller)){
      App.startLoading();
      final result = await Auth().resetPassword(controller.emailAddress.value);
      App.stopLoading();

      if(result) controller.changeTab(1);
    }
  }

  bool _validateFields(ResetPasswordController controller) {

    if(controller.emailAddress.trim().isEmpty) {
      controller.emailAddressError.value = "Please input a valid email address";
      return false;
    }else {
      if (!controller.emailAddress.value.isEmail) {
        controller.emailAddressError.value = "Please input a valid email address";
        return false;
      } else {
        controller.emailAddressError.value = "";
      }
    }
    return true;
  }
}
