import 'package:flutter/material.dart';

GestureDetector userDetailsContainer({
  required double width,
  required double height,
  required BuildContext context,
  required String title,
  required Icon icon,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      width: width * 45,
      height: height * 10,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(
              height: 12,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    ),
  );
}
