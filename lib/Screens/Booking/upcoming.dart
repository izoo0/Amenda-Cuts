import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:flutter/material.dart';

Container upcomingContainer(OrderModel data, BuildContext context,
    {required Function onTap,
    required bool value,
    required Function onCancelTap,
    required Function openReceipt}) {
  final Apis instance = Apis.instance;
  SizeConfig().init(context);
  double mWidth = SizeConfig.blockSizeWidth!;
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4)),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
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
                  Switch(
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.appTextColor.withOpacity(0.1)
                : ColorConstants.blackBackground.withOpacity(0.1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(data.serviceModel!.serviceImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hair Cut",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                      constraints: BoxConstraints(
                        maxWidth: mWidth * 90,
                      ),
                      child: Text(
                        data.serviceModel!.serviceName,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
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
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: mWidth * 60,
                    ),
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      data.serviceModel!.description,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: Theme.of(context).primaryColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Divider(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.appTextColor.withOpacity(0.1)
                : ColorConstants.blackBackground.withOpacity(0.1),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Location: ${data.location}"),
            Text("Date: ${instance.dateFormat(date: data.date)}"),
            Text("Time:${data.time}")
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Divider(
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.appTextColor.withOpacity(0.1)
                : ColorConstants.blackBackground.withOpacity(0.1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          ),
        )
      ],
    ),
  );
}
