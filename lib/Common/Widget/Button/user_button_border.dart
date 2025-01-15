import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget userButtonOutline(
    {required width,
    required name,
    required Function onTap,
    required BuildContext context}) {
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
        child: Text(name, style: Theme.of(context).textTheme.bodySmall)),
  );
}
