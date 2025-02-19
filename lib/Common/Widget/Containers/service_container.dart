import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget serviceContainer({
  required String image,
  required serviceName,
  required description,
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
        color: Theme.of(context).cardColor),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              height: mHeight * 18,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            serviceName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(' Ksh $amount',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Theme.of(context).primaryColor)),
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
                      ? Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white
                      : Theme.of(context).primaryColor,
                ),
              ),
              userButton(
                  context: context,
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
