import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Container adminBookings(
    {required BuildContext context,
    required String serviceImage,
    required String serviceName,
    required String userName,
    required String userNumber,
    required String serviceCategory,
    required String time,
    required String date,
    required String amount,
    required Function onTap}) {
  SizeConfig().init(context);
  double mWidth = SizeConfig.blockSizeWidth!;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: Theme.of(context).cardColor,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          ClipRect(
              child: CachedNetworkImage(
            imageUrl: serviceImage,
            width: mWidth * 20,
          )),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(serviceName),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(userNumber),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(userName),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
                Text(serviceCategory),
                const SizedBox(
                  height: 4,
                ),
                Text(date),
                const SizedBox(
                  height: 4,
                ),
                Text(time),
                const SizedBox(
                  height: 4,
                ),
                Text(amount),
                const SizedBox(
                  height: 4,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      onTap();
                    },
                    child: Text(
                      "Completed",
                      style: Theme.of(context).textTheme.bodySmall,
                    ))
              ],
            ),
          )
        ],
      ),
    ),
  );
}
