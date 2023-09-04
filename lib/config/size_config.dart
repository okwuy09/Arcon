import 'package:flutter/material.dart';

class SizeConfig {
  BuildContext context;

  SizeConfig(this.context);

  double get deviceHeight => MediaQuery.of(context).size.height;
  double get deviceWidth => MediaQuery.of(context).size.width;
}