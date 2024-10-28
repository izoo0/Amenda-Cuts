import 'dart:ui';

import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget categoryContainer({
  required child,
}) {
  return Stack(
    children: [
      Container(
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                ColorConstants.appColor.withOpacity(0.4),
                ColorConstants.appColor.withOpacity(0.2)
              ],
              stops: const [0.0, 1.0],
            )),
        child: child,
      )
    ],
  );
}
