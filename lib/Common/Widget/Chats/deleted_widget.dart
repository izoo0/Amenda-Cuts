import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget deletedCard({required BuildContext context, required ChatModel msg}) {
  Apis apisInstance = Apis.instance;
  SizeConfig().init(context);
  double width = SizeConfig.blockSizeWidth!;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Align(
      alignment: apisInstance.user!.uid == msg.userId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: width * 80,
          minWidth: width * 20,
          minHeight: width * 8,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: apisInstance.user!.uid == msg.userId
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Iconsax.info_circle,
                  size: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "You have deleted this message",
                  style: apisInstance.user!.uid == msg.userId
                      ? Theme.of(context).textTheme.bodySmall!.apply(
                          color: Colors.black38, fontStyle: FontStyle.italic)
                      : Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
