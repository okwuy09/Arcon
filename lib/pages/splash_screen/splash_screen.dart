import 'dart:async';

import 'package:arcon/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/pages/shared/shared.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () async {
      if(Auth().isSignedIn){
        Get.offAllNamed(homeRoute);
      }else {
        Get.offAllNamed(signInRoute);
      }
    });

    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Dimen.horizontalExtender,

                const Expanded(flex: 1, child: SizedBox()),

                Container(
                  padding: EdgeInsets.all(Dimen.horizontalMarginWidth * 3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ResponsiveWidget(
                    smallScreen: Image.asset(
                      'assets/images/logo.jpg',
                      height: Dimen.width * 0.25,
                      width: Dimen.width * 0.25,
                    ),
                    largeScreen: Image.asset(
                      'assets/images/logo.jpg',
                      height: Dimen.width * 0.15,
                      width: Dimen.width * 0.15,
                    ),
                  ),
                ),

                const Expanded(flex: 1, child: SizedBox()),
              ],
            );
          }
      ),
    );
  }
}
