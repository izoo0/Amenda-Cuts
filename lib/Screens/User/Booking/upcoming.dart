import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Container upcomingContainer(OrderModel data, BuildContext context,
    {required Function onTap,
    required bool value,
    required Function onCancelTap,
    required Function openReceipt}) {
  final Apis instance = Apis.instance;
  SizeConfig().init(context);
  double mWidth = SizeConfig.blockSizeWidth!;
  double height = SizeConfig.blockSizeHeight!;
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                instance.getDateString(data.timestamp),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Row(
                children: [
                  Text(
                    "Remind Me",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Switch.adaptive(
                    activeColor: ColorConstants.appColor,
                    inactiveThumbColor:
                        ColorConstants.appTextColor.withOpacity(0.8),
                    value: value,
                    onChanged: (bool value) {
                      onTap(value);
                    },
                  ),
                ],
              ),
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
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hair Cut",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      data.serviceModel!.serviceName,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 4,
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
                          color: Theme.of(context).primaryColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(),
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Location: ${data.location}"),
                VerticalDivider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.appTextColor.withOpacity(0.1)
                      : ColorConstants.blackBackground.withOpacity(0.1),
                ),
                Text("Date: ${instance.dateFormat(date: data.date)}"),
                VerticalDivider(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorConstants.appTextColor.withOpacity(0.1)
                      : ColorConstants.blackBackground.withOpacity(0.1),
                ),
                Text("Time:${data.time}")
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              userButtonOutline(
                context: context,
                width: mWidth * 40,
                name: "Cancel Booking",
                onTap: () {
                  onCancelTap();
                },
              ),
              userButton(
                  context: context,
                  color: Theme.of(context).primaryColor,
                  width: mWidth * 40,
                  name: "View E-Receipt",
                  onTap: () {
                    openReceipt();
                  }),
            ],
          )
        ],
      ),
    ),
  );
}
