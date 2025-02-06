import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Models/chat_model.dart';
import 'package:amenda_cuts/Models/other_users_model.dart';
import 'package:amenda_cuts/Provider/other_user_details_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget replyMessage(
    {required ChatModel msg,
    required BuildContext context,
    required double textWidth}) {
  User? user = FirebaseAuth.instance.currentUser;
  bool isCurrentUser = FirebaseAuth.instance.currentUser != null;
  OtherUserDetailsProvider otherUserDetailsProvider =
      Provider.of(context, listen: false);
  String userNames = otherUserDetailsProvider.otherUserModel
          .firstWhere((data) => data.otherUserId == msg.replyTo.userId,
              orElse: () => OtherUsersModel())
          .name ??
      '';
  bool currentUser = false;

  String userName = "";
  if (msg.replyTo.userId != null && user!.uid == msg.replyTo.userId) {
    userName = "Me";
  } else {
    userName = userNames;
  }
  SizeConfig().init(context);
  double width = SizeConfig.blockSizeWidth!;
  return IntrinsicWidth(
    child: Container(
      width: textWidth,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 255, 255, 255).withOpacity(0.25)
            : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 3,
              decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  )),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.redAccent, fontWeightDelta: 2),
                  ),
                  Text(
                    msg.replyTo.text ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: isCurrentUser
                        ? Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(color: Colors.black)
                        : Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
