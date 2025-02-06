import 'package:amenda_cuts/Common/Widget/Alerts/delete_alert.dart';
import 'package:amenda_cuts/Common/Widget/Alerts/snack_alert.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_interaction_action.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/loading_widget.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

chatInteractionSheet(
    {required BuildContext context,
    required ChatModel message,
    required String chatId,
    required Function replyOnTap}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        Apis instance = Apis.instance;
        return StatefulBuilder(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Theme.of(context).cardColor,
              child: SizedBox(
                width: 470,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black12),
                        child: Text(
                          message.textMessage,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: reactionList.length,
                        itemBuilder: (context, index) {
                          final data = reactionList[index];
                          return ListTile(
                            onTap: () async {
                              if (data.title == "Copy") {
                                await instance.copyToClipBoard(
                                    text: message.textMessage,
                                    context: context);
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              } else if (data.title == "Reply") {
                                replyOnTap();
                              } else if (data.title == "Delete") {
                                if (message.userId == instance.user!.uid) {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DeleteAnimatedAlert(
                                          userId: message.userId,
                                          title: "Delete Message",
                                          body: "Hello there",
                                          chatId: chatId,
                                          messageId: message.messageId,
                                        );
                                      });
                                }
                              }
                              if (context.mounted) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackAlert(
                                        context: context,
                                        info: "Deleting",
                                        child: loadingWidget(),
                                        icon: Iconsax.trash));
                                await instance.deleteForMe(
                                    messageId: message.messageId,
                                    chatId: chatId,
                                    userId: instance.user!.uid,
                                    context: context);
                              }
                            },
                            leading: data.leading,
                            title: Text(
                              data.title,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
}
