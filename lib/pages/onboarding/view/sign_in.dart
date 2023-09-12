import 'package:arcon/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key){
    Get.put(SignInController());
  }

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<SignInController>();
    return LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveWidget.isExtraSmallScreen()
                  || ResponsiveWidget.isMediumScreen() ? width * 0.075 : width * 0.15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 1, child: SizedBox()),

                SizedBox(
                  height: height * 0.88,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          height: App.screenHeight * 0.15,
                          width: App.screenHeight * 0.15,
                        ),
                      ),

                      const Expanded(flex: 1, child: SizedBox()),

                      Padding(
                        padding: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
                        child: CustomText(
                            "Sign In",
                            style: TextStyles(
                                color: CustomColors.grey[5]
                            ).displayTitleLarge
                        ),
                      ),

                      SizedBox(height: Dimen.verticalMarginHeight),

                      Padding(
                        padding: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
                        child: CustomText(
                            "Enter your credentials to continue",
                            style: TextStyles(
                                color: CustomColors.grey[5]
                            ).textBodyLarge
                        ),
                      ),

                      SizedBox(height: Dimen.verticalMarginHeight * 2),

                      SizedBox(
                        height: height * 0.38,
                        child: _Body(width: width * 0.7)
                      ),

                      SizedBox(height: Dimen.verticalMarginHeight),

                      CustomButton(
                        text: "SIGN IN",
                        onPressed: () {
                          _signIn(controller);
                        },
                        margin: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
                      ),

                      SizedBox(height: Dimen.verticalMarginHeight),

                      CustomButton(
                        text: "Don't have an account? - Sign Up",
                        textColor: CustomColors.primary,
                        borderColor: CustomColors.primary,
                        color: Colors.white,
                        onPressed: () {
                          Get.toNamed(signUpRoute);
                        },
                        margin: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
                      ),
                    ],
                  ),
                ),

                const Expanded(flex: 1, child: SizedBox()),

              ],
            ),
          );
        }
    );
  }

  void _signIn(SignInController controller) async {
    if (_validateFields(controller)) {
      App.startLoading();
      await Auth().signIn(controller.emailAddress.value, controller.password.value);
      App.stopLoading();

      if (Auth().isSignedIn) {
        Snack.show(message: 'Sign in successful', type: SnackBarType.success);
        Get.offAllNamed(homeRoute);
      } else {
        Auth().authFailed();
      }
    }
  }

  bool _validateFields(SignInController controller) {

    if(controller.emailAddress.trim().isEmpty) {
      controller.emailAddressError.value = "Please input a valid email address";
      return false;
    }else {
      if (!controller.emailAddress.value.isEmail) {
        controller.emailAddressError.value =
        "Please input a valid email address";
        return false;
      } else {
        controller.emailAddressError.value = "";
      }
    }

    if (controller.password.value.length < 8) {
      controller.passwordError.value = "Your password should be at least 8 characters long";
      return false;
    } else {
      controller.passwordError.value = "";
    }

    return true;
  }
}

class _Body extends StatefulWidget {
  final double width;
  const _Body({Key? key, required this.width}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {

    TextEditingController email =  TextEditingController();
    TextEditingController password =  TextEditingController();

    final controller = Get.find<SignInController>();

    email.text = controller.emailAddress.value;
    password.text = "";

    return Padding(
      padding: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(height: Dimen.verticalMarginHeight * 0.5),

          GetX<SignInController>(
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

          SizedBox(height: Dimen.verticalMarginHeight * 1.5),

          GetX<SignInController>(
              builder: (controller) {

                if(controller.password.value != "" && password.text == ""){
                  password.text = controller.password.value;
                }

                return CustomTextField(
                  height: Constants.screenHeight * 0.06,
                  controller: password,
                  hintText: "Enter your password",
                  labelText: "Password",
                  errorText: controller.passwordError
                      .value == "" ? null : controller
                      .passwordError.value,
                  onObscurityChange: (_) {
                    controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                  },
                  counterText: "",
                  onChanged: (value) => controller.password.value = value,
                  maxLength: 24,
                  obscureText: !controller.isPasswordVisible.value,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r"[#?!@$%^&-*a-zA-Z\d]")),
                  ],
                );
              }
          ),

          SizedBox(height: Dimen.verticalMarginHeight * 1.5),

          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: Constants.screenHeight * 0.03,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(forgotPasswordRoute);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: Dimen.horizontalMarginWidth * 0.5),
                ),
                child: CustomText(
                  "Forgot Password?",
                  textAlign: TextAlign.center,
                  style: TextStyles(
                    color: CustomColors.primary,
                  ).textBodyLarge,
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
