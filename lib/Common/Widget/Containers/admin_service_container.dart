import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget adminServiceContainer({
  required String image,
  required serviceName,
  required description,
  required amount,
  ServiceModel? serviceModel,
  required Function onTapDelete,
  required bool isFavorite,
  required Function onTapEdit,
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
              width: double.infinity,
              height: mHeight * 18,
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
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  onTapEdit();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: const Icon(
                    Iconsax.edit,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  onTapDelete();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: const Icon(
                    Iconsax.trash,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
