import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:amenda_cuts/Screens/Receipt/receipt.dart';
import 'package:flutter/material.dart';

Container completedContainer(OrderModel data, BuildContext context) {
  SizeConfig().init(context);
  double mWidth = SizeConfig.blockSizeWidth!;
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: ColorConstants.blackBackground,
        borderRadius: BorderRadius.circular(4)),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Apis().GetDateString(data.timestamp),
                style: const TextStyle(color: ColorConstants.appTextColor),
              ),
              userButtton(
                  width: mWidth * 20,
                  name: "Completed",
                  onTap: () {},
                  color: Colors.green)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            color: ColorConstants.appTextColor.withOpacity(0.1),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorConstants.appTextColor),
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
                        style:
                            const TextStyle(color: ColorConstants.appTextColor),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Description:',
                    style: TextStyle(
                      color: ColorConstants.appTextColor,
                    ),
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
                      data.serviceModel!.discreption,
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: ColorConstants.appColor.withOpacity(0.7),
                      ),
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
            color: ColorConstants.appTextColor.withOpacity(0.1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16,
          ),
          child: userButttonOutline(
              width: mWidth * 90,
              name: "View Receipt",
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Receipt()));
              }),
        )
      ],
    ),
  );
}
