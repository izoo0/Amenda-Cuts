import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:amenda_cuts/Screens/User/Receipt/receipt.dart';
import 'package:flutter/material.dart';

Container completedContainer(OrderModel data, BuildContext context) {
  SizeConfig().init(context);
  double mWidth = SizeConfig.blockSizeWidth!;
  final Apis instance = Apis.instance;
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
              userButton(
                  context: context,
                  width: mWidth * 30,
                  name: "Completed",
                  onTap: () {},
                  color: Colors.green)
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
                  child: Image(
                    image: NetworkImage(data.serviceModel!.serviceImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: mWidth * 62,
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
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: ColorConstants.appColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(),
          userButtonOutline(
              context: context,
              width: mWidth * 90,
              name: "View Receipt",
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Receipt()));
              })
        ],
      ),
    ),
  );
}
