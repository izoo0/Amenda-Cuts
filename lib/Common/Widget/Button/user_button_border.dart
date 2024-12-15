import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget userButttonOutline(
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
