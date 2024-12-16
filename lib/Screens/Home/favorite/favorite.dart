import 'package:amenda_cuts/Common/Widget/Button/button.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:flutter/material.dart';

Widget favoritewidget(
    {required String image,
    required String discreption,
    required String servicename,
    required String price,
    required bool isFavorite,
    required Function onTap,
    required BuildContext context}) {
  SizeConfig().init(context);
  double mWidth = SizeConfig.blockSizeWidth!;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ColorConstants.appBackground.withOpacity(0.2)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image(
                  image: NetworkImage(image),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    servicename,
                    style: const TextStyle(
                      fontSize: 18,
                      color: ColorConstants.appTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: mWidth * 65,
                    ),
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      discreption,
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: ColorConstants.appTextColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' Ksh $price',
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstants.appColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        button(
            onTap: () {
              onTap();
            },
            text: isFavorite ? "Unfavorite" : "Favorite",
            color: ColorConstants.appColor)
      ],
    ),
  );
}