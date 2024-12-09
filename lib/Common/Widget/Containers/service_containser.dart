import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget serviceContainer({
  required String image,
  required serviceName,
  required discreption,
  required amount,
  ServiceModel? serviceModel,
  required Function onTap,
  required bool isFavorite,
  required Function onTapBook,
  required BuildContext context,
}) {
  SizeConfig().init(context);
  double mWidth = SizeConfig.blockSizeWidth!;
  double mHeight = SizeConfig.blockSizeHeight!;
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstants.blackBackground),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                height: mHeight * 18,
              )),
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
          Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            discreption,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: ColorConstants.appTextColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            ' Ksh $amount',
            style: const TextStyle(
              fontSize: 14,
              color: ColorConstants.appColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
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
              userButtton(
                  width: mWidth * 35,
                  name: 'Book Now',
                  onTap: () {
                    onTapBook();
                  },
                  color: ColorConstants.appColor),
            ],
          ),
        ],
      ),
    ),
  );
}
