import 'package:amenda_cuts/Common/Widget/Gradient/gradient_widget.dart';
import 'package:flutter/material.dart';

Widget categoryContainer(
    {required BuildContext context,
    required String path,
    required String category}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: linearGradient()),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Image(
                    image: AssetImage(path),
                    width: 5,
                  ),
                ))
          ],
        ),
        Text(
          category,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    ),
  );
}
