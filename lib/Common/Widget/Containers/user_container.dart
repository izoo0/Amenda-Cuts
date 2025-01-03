import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Models/users_model.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget userContainer({required BuildContext context}) {
  SizeConfig().init(context);
  double width = SizeConfig.blockSizeWidth!;
  return Consumer<UserDetailsProvider>(
      builder: (context, userDetailsProvider, _) {
    UsersModel userDetails = userDetailsProvider.usersModel;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).cardColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: userDetails.profile ?? '',
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(userDetails.name ?? 'No name'),
                        Checkbox(value: false, onChanged: (val) {}),
                      ],
                    ),
                    Text(userDetails.email ?? ''),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(userDetails.name ?? 'No name'),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  });
}
