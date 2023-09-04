import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arcon/config/config.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;
  final Widget? extraSmallScreen;
  const ResponsiveWidget({required this.largeScreen, this.mediumScreen, this.smallScreen, this.extraSmallScreen, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? mediumScreen = this.mediumScreen;
    Widget? smallScreen= this.smallScreen;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (smallScreen != null && mediumScreen == null) {
          mediumScreen = smallScreen;
        }

        if (isLargeScreen()) {
          return largeScreen;
        } else if (isMediumScreen()) {
          return mediumScreen ?? largeScreen;
        } else if(isSmallScreen()){
          return smallScreen ?? largeScreen;
        }else {
          return extraSmallScreen ?? smallScreen ?? mediumScreen ?? largeScreen;
        }
      },
    );
  }

  static bool isExtraSmallScreen({double? maxWidth}) {
    final width = maxWidth ?? SizeConfig(Get.context!).deviceWidth;

    if(width <= Constants.extraSmallScreenSize){
      return true;
    }else if(MediaQuery.of(Get.context!).orientation == Orientation.landscape
        && width <= Constants.extraSmallScreenSize){
      return true;
    }else{
      return false;
    }
  }

  static bool isSmallScreen({double? maxWidth}) {
    final width = maxWidth ?? SizeConfig(Get.context!).deviceWidth;

    return width > Constants.extraSmallScreenSize &&
        width <= Constants.smallScreenSize;
  }

  static bool isMediumScreen({double? maxWidth}) {
    final width = maxWidth ?? SizeConfig(Get.context!).deviceWidth;

    return width > Constants.smallScreenSize &&
        width <= Constants.mediumScreenSize;
  }

  static bool isLargeScreen({double? maxWidth}) {
    final width = maxWidth ?? SizeConfig(Get.context!).deviceWidth;
    return width > Constants.mediumScreenSize;
  }
}

class ConditionalBuilder extends StatelessWidget {
  final List<bool> conditions;
  final Widget Function(BuildContext) fulfilledBuilder;
  final Widget Function(BuildContext)? unfulfilledBuilder;

  const ConditionalBuilder({Key? key, required this.conditions, required this.fulfilledBuilder, this.unfulfilledBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      if(isConditionFulfilled){
        return fulfilledBuilder(context);
      }else {
        return unfulfilledBuilder != null ? unfulfilledBuilder!(context) : const SizedBox();
      }
    });
  }

  bool get isConditionFulfilled {
    bool isConditionFulfilled = true;
    for(bool condition in conditions){
      if(!condition) isConditionFulfilled = false;
    }
    return isConditionFulfilled;
  }

}
