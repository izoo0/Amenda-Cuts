import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget iconContainer({
  required double width,
  required String image,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      color: ColorConstants.blackBackground,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Image(
        image: AssetImage(image),
        width: 20,
      ),
    ),
  );
}
