import 'package:flutter/material.dart';

Widget button(
    {required Function onTap,
    required String text,
    Color? color,
    Image? image,
    required BuildContext context}) {
  return MaterialButton(
      minWidth: double.infinity,
      height: 42,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 2,
      color: Theme.of(context).primaryColor,
      onPressed: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null) image,
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.black54)),
        ],
      ));
}
