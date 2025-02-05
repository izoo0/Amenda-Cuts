import 'package:amenda_cuts/Models/other_users_model.dart';
import 'package:amenda_cuts/Models/reply_model.dart';
import 'package:amenda_cuts/Provider/other_user_details_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

Widget replyWidget(
    {required BuildContext context,
    required ReplyModel msg,
    required Function onTap}) {
  User? user = FirebaseAuth.instance.currentUser;
  OtherUserDetailsProvider otherUserDetailsProvider =
      Provider.of(context, listen: false);
  String userNames = otherUserDetailsProvider.otherUserModel
          .firstWhere((data) => data.otherUserId == msg.userId,
              orElse: () => OtherUsersModel())
          .name ??
      '';

  String userName = "";
  if (user!.uid == msg.userId && msg.userId != null) {
    userName = "Me";
  } else {
    userName = userNames;
  }
  return IntrinsicHeight(
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              width: 3,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      userName,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: Colors.red, fontWeightDelta: 2),
                    ),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      msg.text ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  onTap();
                },
                child: const Icon(Iconsax.close_circle))
          ],
        ),
      ),
    ),
  );
}
