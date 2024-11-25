import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget sliderContainer() {
  return Container(
    width: double.infinity,
    height: 200,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              ColorConstants.appColor.withOpacity(0.4),
              ColorConstants.appColor.withOpacity(0.2),
            ],
            stops: const [
              0.0,
              1.0
            ])),
  );
}
