import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arcon/config/config.dart';

class Snack {

  Snack.show({required String message, required SnackBarType type, bool floating = false, int length = 0}){

    final double maxWidth = floating
        ? Dimen.width - 80 <= 500
          ? Dimen.width - 80 : 500
        : Dimen.width;

    double leftMargin = Dimen.width - (maxWidth + 40);
    if(leftMargin.isNegative) leftMargin = 0;

    final EdgeInsets margin = floating
        ? EdgeInsets.only(left: leftMargin, bottom: 20)
        : EdgeInsets.zero;

    Get.showSnackbar(
        GetSnackBar(
          messageText: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'TomatoGrotesk',
              letterSpacing: 0.03,
            ),
          ),
          maxWidth: maxWidth,
          snackStyle: floating ? SnackStyle.FLOATING : SnackStyle.GROUNDED,
          margin: margin,
          snackPosition: floating ? SnackPosition.BOTTOM : SnackPosition.TOP,
          animationDuration: const Duration(milliseconds: 500),
          duration: length == 0 ? const Duration(milliseconds: 2000) : const Duration(milliseconds: 4000),
          backgroundColor: getBackgroundColor(type),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
        )
    );
  }

  Color getBackgroundColor(SnackBarType type) {
    if (type == SnackBarType.error) return CustomColors.error;
    if (type == SnackBarType.warning) return CustomColors.warning;
    if (type == SnackBarType.success) return CustomColors.success;
    if (type == SnackBarType.info) return CustomColors.info;
    return CustomColors.grey[5]!;
  }

}

enum SnackBarType {info, success, warning, error}