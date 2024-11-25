import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget userButtton({
  required width,
  required name,
  required color,
  required Function onTap,
}) {
  return SizedBox(
    width: width,
    child: TextButton(
        onPressed: () {
          onTap();
        },
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: ColorConstants.appTextColor,
          ),
        )),
  );
}
