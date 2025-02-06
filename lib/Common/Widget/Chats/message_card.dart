import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_interaction_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Chats/reply_message.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

Widget messageCard(
    {required ChatModel msg,
    required BuildContext context,
    required String chatId,
    required double replyWidth,
    required double textWidth,
    required Function onSwipe,
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
              Text(
                apisInstance.dates(date: msg.time),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
