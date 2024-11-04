import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget serviceContainer({
  required image,
  required serviceName,
  required discreption,
  required amount,
  required maxWidth,
  ServiceModel? serviceModel,
  required Function onTap,
  required bool isFavorite,
  required Function onTapBook,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ColorConstants.blackBackground.withOpacity(0.5),
            ColorConstants.blackBackground.withOpacity(0.2),
          ],
          stops: const [
            0.0,
            0.1
          ]),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: SizedBox(
            height: 120,
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              serviceName,
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
                maxWidth: maxWidth,
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
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' Ksh $amount',
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorConstants.appColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 170,
                ),
                userButtton(
                    width: 80.0,
                    name: 'Book Now',
                    onTap: () {
                      onTapBook();
                    },
                    color: ColorConstants.appColor)
              ],
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: GestureDetector(
            onTap: () {
              onTap();
            },
            child: Icon(
              !isFavorite ? Iconsax.archive_add : Iconsax.archive_1,
              color: !isFavorite
                  ? ColorConstants.appTextColor
                  : ColorConstants.appColor,
            ),
          ),
        )
      ],
    ),
  );
}
