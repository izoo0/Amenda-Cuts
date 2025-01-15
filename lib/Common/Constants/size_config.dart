import 'package:flutter/material.dart';

class SizeConfig {
  static double? blockSizeHeight;
  static double? blockSizeWidth;

  init(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    blockSizeHeight = height / 100;
    blockSizeWidth = width / 100;
  }
}
