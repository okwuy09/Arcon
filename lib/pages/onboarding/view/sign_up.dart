import 'package:arcon/logic/models/models.dart';
import 'package:arcon/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key){
    Get.put(SignUpController());
  }

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<SignUpController>();
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
                  height: height * 0.84,
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
                            "Sign Up",
                            style: TextStyles(
                                color: CustomColors.grey[5]
                            ).displayTitleLarge
                        ),
                      ),

                      SizedBox(height: Dimen.verticalMarginHeight),

                      Padding(
                        padding: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
                        child: CustomText(
                            "Enter your credentials to create your account",
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

                      SizedBox(height: Dimen.verticalMarginHeight * 3),

                      CustomButton(
                        text: "SIGN UP",
                        onPressed: () {
                          _signUp(controller);
                        },
                        margin: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
                      ),

                      SizedBox(height: Dimen.verticalMarginHeight * 1.5),

                      Center(
                        child: Container(
                          height: Constants.screenHeight * 0.03,
                          margin: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(signInRoute);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: CustomText(
                              "Already have an account? - Sign In",
                              textAlign: TextAlign.center,
                              style: TextStyles(
                                color: CustomColors.grey[5],
                              ).textBodyLarge,
                            ),
                          ),
                        ),
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

  void _signUp(SignUpController controller) async {
    if (_validateFields(controller)) {
      App.startLoading();
      await Auth().signUp(controller.emailAddress.value, controller.password.value);

      if (Auth().isSignedIn) {
        await _createUser(controller, Auth().uID);
        App.stopLoading();

        Snack.show(message: 'Sign up successful', type: SnackBarType.success);
        Get.offAllNamed(homeRoute);

      } else {
        App.stopLoading();
        Auth().authFailed();
      }
    }
  }

  bool _validateFields(SignUpController controller) {

    if(controller.name.value.trim().isEmpty){
      controller.nameError.value = "Please input a valid name";
      return false;
    } else {
      controller.nameError.value = "";
    }

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

  Future<void> _createUser (SignUpController controller, String uID) async {

    final User user = User(
        id: uID,
        name: controller.name.value,
        email: controller.emailAddress.value,
    );

    await UserDatabase(uID).createUser(user.toJson());
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

    TextEditingController name =  TextEditingController();
    TextEditingController email =  TextEditingController();
    TextEditingController password =  TextEditingController();

    final controller = Get.find<SignUpController>();

    name.text = controller.name.value;
    email.text = controller.emailAddress.value;
    password.text = "";

    return Padding(
      padding: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(height: Dimen.verticalMarginHeight * 0.5),

          GetX<SignUpController>(
              builder: (controller) {

                if(controller.name.value != "" && name.text == ""){
                  name.text = controller.name.value;
                }
                return CustomTextField(
                  height: Constants.screenHeight * 0.06,
                  controller: name,
                  labelText: "Name",
                  hintText: "Enter your full name",
                  errorText: controller.nameError
                      .value == "" ? null : controller
                      .nameError.value,
                  onChanged: (value) => controller.name.value = value,
                  keyboardType: TextInputType.name,
                );
              }
          ),

          SizedBox(height: Dimen.verticalMarginHeight * 1.5),

          GetX<SignUpController>(
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

          GetX<SignUpController>(
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

        ],
      ),
    );
  }
}
