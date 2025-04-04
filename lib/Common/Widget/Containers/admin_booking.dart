import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/preloader.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:amenda_cuts/Models/other_users_model.dart';
import 'package:amenda_cuts/Provider/other_user_details_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Widget adminBookings({
  required BuildContext context,
  required OrderModel orderModel,
}) {
  SizeConfig().init(context);
  double mWidth = SizeConfig.blockSizeWidth!;
  double mHeight = SizeConfig.blockSizeHeight!;
  Apis instance = Apis.instance;
  return Consumer<OtherUserDetailsProvider>(
      builder: (context, otherUserDetail, _) {
    String? otherUserName({required String otherUserId}) {
      var user = otherUserDetail.otherUserModel.firstWhere(
        (data) => data.otherUserId == otherUserId,
        orElse: () => OtherUsersModel(),
      );

      return user.name;
    }

    String? otherUserNumber({required String otherUserId}) {
      var user = otherUserDetail.otherUserModel.firstWhere(
        (data) => data.otherUserId == otherUserId,
        orElse: () => OtherUsersModel(),
      );

      return user.number;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: orderModel.serviceModel!.serviceImage,
                  width: mWidth * 28,
                  height: mHeight * 15,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(orderModel.serviceModel!.serviceName),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(otherUserNumber(
                              otherUserId: orderModel.userId ?? '') ??
                          ''),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                          otherUserName(otherUserId: orderModel.userId ?? '') ??
                              ''),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                  Text(orderModel.serviceModel!.serviceCategory),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(formattedDate(date: orderModel.date)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(orderModel.time ?? ''),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Ksh ${orderModel.serviceModel!.servicePrice}'),
                  const SizedBox(
                    height: 4,
                  ),
                  orderModel.status == "upcoming"
                      ? TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return preloader(20.0, context);
                                });
                            await instance.adminComplete(
                                context: context, docId: orderModel.orderId);
                          },
                          child: Text(
                            "Mark as completed",
                            style: Theme.of(context).textTheme.bodySmall,
                          ))
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: orderModel.status == "completed"
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            orderModel.status == "completed"
                                ? "Completed"
                                : "Canceled",
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  });
}

String formattedDate({required date}) {
  return DateFormat("y-mM-d").format(date);
}
