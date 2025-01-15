import 'package:flutter/material.dart';

Widget button(
    {required Function onTap,
    required String text,
    Color? color,
    Image? image,
    required BuildContext context}) {
  return SizedBox(
    width: double.infinity,
    child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (image != null) image,
              Text(text, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        )),
  );
}
