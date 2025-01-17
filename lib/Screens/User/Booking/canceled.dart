import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Container cancelledContainer(
  OrderModel data,
  BuildContext context,
) {
  SizeConfig().init(context);
  double mWidth = SizeConfig.blockSizeWidth!;
  final Apis instance = Apis.instance;
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                instance.getDateString(data.timestamp),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              userButton(
                context: context,
                width: 80.0,
                name: 'Cancel',
                onTap: () {},
                color: Colors.redAccent,
              )
            ],
          ),
          const Divider(),
          Row(
            children: [
              Container(
                width: mWidth * 28,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: data.serviceModel!.serviceImage,
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.serviceModel!.serviceName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.serviceModel!.serviceCategory,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Description:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      data.serviceModel!.description,
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                          color: ColorConstants.appColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
