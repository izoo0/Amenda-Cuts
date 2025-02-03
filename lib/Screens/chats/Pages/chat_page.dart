import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_interaction_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_text_field.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String replyMsg = '';
  List<ChatModel> messages = [];
  FirebaseFirestore instance = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Apis apisInstance = Apis.instance;
  fetchMessages() {
    instance
        .collection("messages")
        .doc("IRZTtnkM3jQUJ2zCOAJb")
        .collection("chats")
        .orderBy("timestamp")
        .snapshots()
        .listen((snap) {
      List<ChatModel> newMessages = [];

      for (var doc in snap.docs) {
        if (doc.exists) {
          String docId = doc.id;
          Map<String, dynamic> mapData = doc.data();
          newMessages
              .add(ChatModel.fromFirebase(msgData: mapData, msgId: docId));
          setState(() {
            messages = newMessages;
          });
        }
      }
      print("Fetched Messages: $newMessages");
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.blockSizeWidth!;
    return NewAppBackground(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: const Text("Hello"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<ChatModel, DateTime>(
              elements: messages,
              groupSeparatorBuilder: (DateTime message) => Center(
                child: Card(
                  color: ColorConstants.blackBackground,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2.0),
                    child: Text(apisInstance.dateFormat(date: message)),
                  ),
                ),
              ),
              groupBy: (messages) => messages.time,
              reverse: true,
              sort: false,
              itemBuilder: (context, ChatModel msg) {
                return SwipeTo(
                  onRightSwipe: (details) {
                    setState(() {
                      replyMsg = msg.textMessage;
                    });
                  },
                  child: Align(
                    alignment: user!.uid == msg.userId
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        chatInteractionSheet(
                          context: context,
                          message: msg.textMessage,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: width * 80,
                            minWidth: width * 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Card(
                                color: user!.uid == msg.userId
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: user!.uid == msg.userId
                                        ? const Radius.circular(10)
                                        : const Radius.circular(0),
                                    topRight: const Radius.circular(10),
                                    bottomLeft: const Radius.circular(10),
                                    bottomRight: user!.uid == msg.userId
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      replyMessage(msg: msg, context: context),
                                      Text(
                                        msg.textMessage,
                                        style: user!.uid == msg.userId
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .apply(color: Colors.black)
                                            : Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                      ),
                                    ],
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
                  ),
                );
              },
            ),
          ),
          chatTextField(
            child: replyWidget(
              name: "Isaiah",
              context: context,
              text: replyMsg,
              onTap: () {
                setState(() {
                  replyMsg = '';
                });
              },
            ),
            context: context,
            message: replyMsg,
          )
        ],
      ),
    ));
  }
}

Widget replyWidget(
    {required BuildContext context,
    required String text,
    required String name,
    required Function onTap}) {
  return IntrinsicHeight(
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        children: [
          Container(
            width: 4,
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
                    name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text,
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
  );
}

Widget replyMessage({required ChatModel msg, required BuildContext context}) {
  User? user = FirebaseAuth.instance.currentUser;
  return IntrinsicWidth(
    child: Row(
      children: [
        Container(
          width: 2,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              )),
        ),
        Text(
          msg.replyTo!.text ?? '',
          style: user!.uid == msg.userId
              ? Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: Colors.black)
              : Theme.of(context).textTheme.bodySmall,
        )
      ],
    ),
  );
}
