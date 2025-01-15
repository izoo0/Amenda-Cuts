import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget userButton({
  required width,
  required name,
  required color,
  required Function onTap,
  required BuildContext context,
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
        child: Text(name,
            style: Theme.of(context).textTheme.bodySmall!.apply(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ColorConstants.blackBackground
                    : ColorConstants.appTextColor))),
  );
}
