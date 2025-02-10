import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget chatContainer({
  required ChatHomeModel chatModel,
  required BuildContext context,
  required Function onTap,
}) {
  SizeConfig().init(context);
  double width = SizeConfig.blockSizeWidth!;
  Apis instance = Apis.instance;
  bool isDeleted = chatModel.lastMessageModel.isDeleted;
  bool deleted =
      chatModel.lastMessageModel.deleted.contains(instance.user!.uid);
  bool isEdited = chatModel.lastMessageModel.isEdited;
  return GestureDetector(
    onTap: () {
      onTap();
    },
    onDoubleTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    )),
                child: chatModel.profile.isNotEmpty &&
                        (chatModel.profile.length) > 1
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachedNetworkImage(
                          imageUrl: chatModel.profile,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Text(
                        chatModel.userName[0],
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                  child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 68,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            chatModel.userName,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            isDeleted || deleted
                                ? "This message was deleted"
                                : chatModel
                                        .lastMessageModel.editedMessage.isEmpty
                                    ? chatModel.lastMessageModel.lastText
                                    : chatModel.lastMessageModel.editedMessage,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: isDeleted || deleted
                                ? Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(fontStyle: FontStyle.italic)
                                : Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            instance.getDateString(
                                chatModel.lastMessageModel.messageTime),
                            style: chatModel.counts > 0
                                ? Theme.of(context).textTheme.bodySmall!.apply(
                                    color: Theme.of(context).primaryColor)
                                : Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          if (chatModel.counts > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(12)),
                              child: Text(
                                chatModel.counts > 10
                                    ? "9+"
                                    : chatModel.counts.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(color: Colors.black),
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    ),
  );
}
