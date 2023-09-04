import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/pages/shared/shared.dart';

class PasswordResetSuccessfully extends StatelessWidget {
  const PasswordResetSuccessfully({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [

              Dimen.horizontalExtender,

              const Expanded(flex: 6, child: SizedBox()),

              Builder(
                  builder: (context) {
                    if(ResponsiveWidget.isLargeScreen(maxWidth: constraints.maxWidth * 2)
                        || ResponsiveWidget.isMediumScreen(maxWidth: constraints.maxWidth * 2)){
                      return Container(
                        height: constraints.maxWidth * 0.5,
                        width: constraints.maxWidth * 0.5,
                        color: Colors.transparent,
                        child: Center(
                          child: SVG(
                              'assets/images/password_reset.svg',
                              height: constraints.maxWidth * 0.5,
                              width: constraints.maxWidth * 0.5,
                              semanticsLabel: "Password Reset"
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: constraints.maxWidth * 0.7,
                        width: constraints.maxWidth * 0.7,
                        color: Colors.transparent,
                        child: Center(
                          child: SVG(
                              'assets/images/password_reset.svg',
                              height: constraints.maxWidth * 0.7,
                              width: constraints.maxWidth * 0.7,
                              semanticsLabel: "Password Reset"
                          ),
                        ),
                      );
                    }
                  }
              ),

              SizedBox(height: Dimen.verticalMarginHeight * 2),

              CustomText(
                "Password reset link sent",
                style: TextStyle(
                  color: CustomColors.grey[5],
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: Dimen.verticalMarginHeight),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimen.horizontalMarginWidth * 2),
                child: SizedBox(
                  child: CustomText(
                    "A password reset link has been sent to your email."
                        " Follow the link to reset your password password",
                    style: TextStyles(
                        color: CustomColors.grey[4]
                    ).textBodyExtraLarge,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const Expanded(flex: 3, child: SizedBox()),

              CustomButton(
                text: "RETURN",
                onPressed: () {
                  Get.toNamed(signInRoute);
                },
              ),

              const Expanded(flex: 3, child: SizedBox()),

            ],
          );
        }
    );
  }
}
