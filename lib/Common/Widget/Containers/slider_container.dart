import 'package:flutter/material.dart';

Widget sliderContainer({required BuildContext context, required Widget child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor),
      child: child,
    ),
  );
}
