import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
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
              userButton(
                context: context,
                width: 80.0,
                name: 'Cancel',
                onTap: () {},
                color: Colors.redAccent,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    data.serviceModel!.serviceName,
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
                          color: ColorConstants.appColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
