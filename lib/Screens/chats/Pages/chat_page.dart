import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_interaction_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_text_field.dart';
import 'package:amenda_cuts/Common/Widget/Chats/reply_message.dart';
import 'package:amenda_cuts/Common/Widget/Chats/reply_widget.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_model.dart';
import 'package:amenda_cuts/Models/reply_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ReplyModel replyMsg = ReplyModel();
  List<ChatModel> messages = [];
  FirebaseFirestore instance = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Apis apisInstance = Apis.instance;
  fetchMessages() {
    instance
        .collection("messages")
        .doc("IRZTtnkM3jQUJ2zCOAJb")
        .collection("chats")
        .orderBy("timestamp", descending: true)
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
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 0.8,
                  filterQuality: FilterQuality.medium,
                  image: Theme.of(context).brightness == Brightness.dark
                      ? const AssetImage('assets/Images/bg1.jpg')
                      : const AssetImage('assets/Images/bg.jpg'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
            appBar: AppBar(
              backgroundColor: Theme.of(context).cardColor.withOpacity(0.8),
              title: const Text("Hello"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: GroupedListView<ChatModel, DateTime>(
                    elements: messages,
                    groupSeparatorBuilder: (DateTime message) => Center(
                      child: Card(
                        color: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 2.0),
                          child: Text(apisInstance.dateFormat(date: message)),
                        ),
                      ),
                    ),
                    groupBy: (messages) {
                      return messages.time;
                    },
                    reverse: true,
                    sort: false,
                    floatingHeader: true,
                    itemBuilder: (context, ChatModel msg) {
                      double textWidth =
                          getTextWidth(text: msg.textMessage, context: context);
                      double replyWidth = getTextWidth(
                          text: msg.replyTo.text ?? '', context: context);
                      return SwipeTo(
                        onRightSwipe: (details) {
                          setState(() {
                            replyMsg = ReplyModel(
                                text: msg.textMessage, userId: msg.userId);
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (msg.replyTo.messageId != null &&
                                                msg.replyTo.messageId!.length >
                                                    1)
                                              replyMessage(
                                                  textWidth:
                                                      replyWidth > textWidth
                                                          ? replyWidth
                                                          : textWidth,
                                                  msg: msg,
                                                  context: context),
                                            Text(
                                              msg.textMessage,
                                              style: user!.uid == msg.userId
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .apply(
                                                          color: Colors.black)
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
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
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
                    msg: replyMsg,
                    context: context,
                    onTap: () {
                      setState(() {
                        replyMsg = ReplyModel();
                      });
                    },
                  ),
                  context: context,
                  message: replyMsg.text ?? '',
                )
              ],
            ),
          ),
        ));
  }
}

double getTextWidth({required String text, required BuildContext context}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: Theme.of(context).textTheme.bodySmall),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width;
}
