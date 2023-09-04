import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';

import 'password_reset_successfully.dart';
import 'input_details.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    return _Default();
  }
}

class _Default extends StatelessWidget {
  _Default({Key? key}) : super(key: key);

  final bucket = PageStorageBucket();
  final List<Widget> screens = [
    const InputDetails(),
    const PasswordResetSuccessfully(),
  ];

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<ResetPasswordController>();
    controller.currentTab.value = 0;

    return LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveWidget.isExtraSmallScreen()
                    || ResponsiveWidget.isMediumScreen() ? width * 0.075 : width * 0.15
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Expanded(child: SizedBox()),

                  Container(
                    height: App.screenHeight * 0.84,
                    padding: EdgeInsets.only(right: Dimen.horizontalMarginWidth * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.currentTab.value == 0 || controller.currentTab.value == 3
                                    ? Get.toNamed(signInRoute)
                                    : controller.changeTab(0);
                              },
                              icon: SVG(
                                  'assets/icons/back_arrow.svg',
                                  height: 24,
                                  width: 24,
                                  color: CustomColors.grey[5],
                                  semanticsLabel: "Back"
                              ),
                            ),

                            SizedBox(width: Dimen.horizontalMarginWidth),

                            Image.asset(
                              'assets/images/logo.jpg',
                              height: App.screenHeight * 0.15,
                              width: App.screenHeight * 0.15,
                            )
                          ],
                        ),

                        Expanded(
                          child: GetX<ResetPasswordController>(
                              builder: (controller) {
                                return PageStorage(
                                    bucket: bucket,
                                    child: screens[controller.currentTab.value]
                                );
                              }
                          ),
                        ),

                      ],
                    ),
                  ),

                  const Expanded(child: SizedBox()),
                ]
            ),
          );
        }
    );
  }
}

