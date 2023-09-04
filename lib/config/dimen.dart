import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'size_config.dart';

class Dimen {
  static double get width => SizeConfig(Get.context!).deviceWidth;

  static double get height => SizeConfig(Get.context!).deviceHeight;

  static Widget get verticalMargin {
    return SizedBox(
      height: verticalMarginHeight,
    );
  }

  static double get verticalMarginHeight {
    return gridHeight * (1/6);
  }

  static Widget get verticalExtender {
    return const SizedBox(
      height: double.infinity,
    );
  }


  static double get gridHeight {
    return height * (1/9);
  }

  static Widget get horizontalMargin {
    return SizedBox(
      width: horizontalMarginWidth,
    );
  }

  static double get horizontalMarginWidth {
    return gridWidth * (1/4);
  }

  static Widget get horizontalExtender {
    return const SizedBox(
      width: double.infinity,
    );
  }

  static double get gridWidth {
    return width * (1/14);
  }
}