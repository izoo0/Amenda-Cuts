import 'package:amenda_cuts/Screens/User/Home/service/category_service.dart';
import 'package:flutter/material.dart';

import '../../../../Common/Widget/Gradient/gradient_widget.dart';

Widget categoryButton({
  required BuildContext context,
  required double mWidth,
  required String title,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: GestureDetector(
      onTap: () {
        print(title);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryService(category: title)));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          width: mWidth * 16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: linearGradient()),
          child: Center(
              child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: Colors.white),
          ))),
    ),
  );
}
