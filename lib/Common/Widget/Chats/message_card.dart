import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Alerts/snack_alert.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_interaction_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Chats/reply_message.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/loading_widget.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swipe_to/swipe_to.dart';

Widget messageCard(
    {required ChatModel msg,
    required BuildContext context,
    required String chatId,
    required double replyWidth,
    required double textWidth,
    required Function onSwipe,
    required bool favorite,
    required Function onReplyTap}) {
  Apis apisInstance = Apis.instance;
  SizeConfig().init(context);
  double width = SizeConfig.blockSizeWidth!;
  return SwipeTo(
    onRightSwipe: (details) {
      onSwipe(details);
    },
    child: Align(
      alignment: apisInstance.user!.uid == msg.userId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          chatInteractionSheet(
              isFavorite: favorite,
              chatId: chatId,
              context: context,
              message: msg,
              replyOnTap: () {
                onReplyTap();
              });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: width * 80,
                  minWidth: width * 20,
                  minHeight: width * 8,
                ),
                child: Card(
                  color: apisInstance.user!.uid == msg.userId
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: apisInstance.user!.uid == msg.userId
                          ? const Radius.circular(10)
                          : const Radius.circular(0),
                      topRight: const Radius.circular(10),
                      bottomLeft: const Radius.circular(10),
                      bottomRight: apisInstance.user!.uid == msg.userId
                          ? const Radius.circular(0)
                          : const Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (msg.replyTo.messageId != null &&
                            msg.replyTo.messageId!.length > 1)
                          replyMessage(
                              textWidth: replyWidth > textWidth
                                  ? replyWidth
                                  : textWidth,
                              msg: msg,
                              context: context),
                        Text(
                          msg.textMessage,
                          style: apisInstance.user!.uid == msg.userId
                              ? Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(color: Colors.black)
                              : Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (favorite)
                    GestureDetector(
                        onTap: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackAlert(
                              context: context,
                              info: "Favorite",
                              child: loadingWidget(),
                              icon: Iconsax.star,
                            ),
                          );
                          await apisInstance.favorite(
                              isFavorite: favorite,
                              messageId: msg.messageId,
                              chatId: chatId,
                              userId: apisInstance.user!.uid,
                              context: context);
                        },
                        child: const Icon(
                          Iconsax.star,
                          size: 14,
                        )),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    apisInstance.dates(date: msg.time),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
