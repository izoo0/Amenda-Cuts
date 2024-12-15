import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/size_config.dart';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

bottomSheet(
    {required BuildContext context,
    required double height,
    required Widget child}) {
  SizeConfig().init(context);
  double mHeight = SizeConfig.blockSizeHeight!;
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) {
        return Stack(
          children: [
            Card(
                color: Theme.of(context).cardColor,
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
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    child
                  ]),
                )),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Iconsax.close_circle,
                    size: 32, color: Theme.of(context).primaryColor),
              ),
            )
          ],
        );
      });
}
