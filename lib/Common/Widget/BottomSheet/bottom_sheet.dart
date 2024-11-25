import 'package:amenda_cuts/Constants/color_constants.dart';

import 'package:flutter/material.dart';

bottomSheet(
    {required BuildContext context,
    required double height,
    required Widget child}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) {
        return Card(
            color: ColorConstants.blackBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ColorConstants.appColor,
                    ),
                  ),
                ),
                child
              ]),
            ));
      });
}
