import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget categoryContainer(
    {required BuildContext context,
    required String path,
    required String category}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        Stack(
          children: [
            Container(
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        ColorConstants.appColor.withOpacity(0.4),
                        ColorConstants.appColor.withOpacity(0.2)
                      ],
                      stops: const [0.0, 1.0],
                    )),
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
