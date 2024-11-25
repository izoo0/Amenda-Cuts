import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget userButttonOutline({
  required width,
  required name,
  required Function onTap,
}) {
  return SizedBox(
    width: width,
    child: TextButton(
        onPressed: () {
          onTap();
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(
                width: 1,
                color: ColorConstants.appColor,
              )),
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
