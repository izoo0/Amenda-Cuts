import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_home_model.dart';
import 'package:flutter/material.dart';

Widget chatContainer({
  required ChatHomeModel chatModel,
  required BuildContext context,
  required Function onTap,
}) {
  SizeConfig().init(context);
  double width = SizeConfig.blockSizeWidth!;
  Apis instance = Apis.instance;
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
                      width: width * 72,
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
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            chatModel.lastMessageModel.lastText,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            instance.getDateString(
                                chatModel.lastMessageModel.messageTime),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadiusDirectional.circular(12)),
                            child: Text(
                              chatModel.counts.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
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
