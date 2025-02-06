import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_interaction_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_text_field.dart';
import 'package:amenda_cuts/Common/Widget/Chats/reply_message.dart';
import 'package:amenda_cuts/Common/Widget/Chats/reply_widget.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_home_model.dart';
import 'package:amenda_cuts/Models/chat_model.dart';
import 'package:amenda_cuts/Models/reply_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatPage extends StatefulWidget {
  final ChatHomeModel chatHomeModel;
  const ChatPage({super.key, required this.chatHomeModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ReplyModel replyMsg = ReplyModel();
  List<ChatModel> messages = [];
  Apis apisInstance = Apis.instance;
  late TextEditingController controller;
  String chatId = '';
  fetchMessages() {
    apisInstance.firestore
        .collection("messages")
        .doc(chatId)
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
            updateCount();
          });
        }
      }
    });
  }

  updateCount() {
    DocumentReference documentReference =
        apisInstance.firestore.collection('messages').doc(chatId);
    documentReference.set({
      "unreadCount": {
        apisInstance.user!.uid: 0,
      }
    }, SetOptions(merge: true));
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    chatId = widget.chatHomeModel.chatId;

    fetchMessages();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: Theme.of(context).cardColor.withOpacity(0.8),
              title: Row(
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
                    child: widget.chatHomeModel.profile.isNotEmpty &&
                            (widget.chatHomeModel.profile.length) > 1
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              imageUrl: widget.chatHomeModel.profile,
                              fit: BoxFit.cover,
                            ))
                        : Center(
                            child: Text(
                              widget.chatHomeModel.userName[0],
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.chatHomeModel.userName,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(fontWeightDelta: 3),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: GroupedListView<ChatModel, DateTime>(
                    elements: messages,
                    addAutomaticKeepAlives: true,
                    groupHeaderBuilder: (ChatModel message) => Center(
                      child: Card(
                        color: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 2.0),
                          child:
                              Text(apisInstance.getDatesString(message.time)),
                        ),
                      ),
                    ),
                    groupBy: (messages) {
                      return DateTime(messages.time.day, messages.time.month,
                          messages.time.year);
                    },
                    reverse: true,
                    sort: false,
                    floatingHeader: true,
                    order: GroupedListOrder.DESC,
                    itemBuilder: (context, ChatModel msg) {
                      double textWidth =
                          getTextWidth(text: msg.textMessage, context: context);
                      double replyWidth = getTextWidth(
                          text: msg.replyTo.text ?? '', context: context);
                      return SwipeTo(
                        onRightSwipe: (details) {
                          setState(() {
                            replyMsg = ReplyModel(
                                text: msg.textMessage,
                                userId: msg.userId,
                                messageId: msg.messageId);
                          });
                        },
                        child: Align(
                          alignment: apisInstance.user!.uid == msg.userId
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              chatInteractionSheet(
                                  context: context,
                                  message: msg,
                                  replyOnTap: () {
                                    setState(() {
                                      replyMsg = ReplyModel(
                                          messageId: msg.messageId,
                                          userId: msg.userId,
                                          text: msg.textMessage);
                                    });
                                    Navigator.pop(context);
                                  });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                      color:
                                          apisInstance.user!.uid == msg.userId
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context).cardColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: apisInstance.user!.uid ==
                                                  msg.userId
                                              ? const Radius.circular(10)
                                              : const Radius.circular(0),
                                          topRight: const Radius.circular(10),
                                          bottomLeft: const Radius.circular(10),
                                          bottomRight: apisInstance.user!.uid ==
                                                  msg.userId
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
                                              style: apisInstance.user!.uid ==
                                                      msg.userId
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
                      );
                    },
                  ),
                ),
                chatTextField(
                  controller: controller,
                  onTap: () async {
                    await apisInstance.sendMessage(
                      replyUserId: replyMsg.userId ?? '',
                      otherUserId: widget.chatHomeModel.otherUserId,
                      chatId: chatId,
                      message: controller.text.trim(),
                      userId: apisInstance.user!.uid,
                      messageId: replyMsg.messageId != null
                          ? replyMsg.messageId ?? ""
                          : "",
                      text: replyMsg.text != null ? replyMsg.text ?? '' : "",
                    );
                    controller.clear();
                    setState(() {
                      replyMsg = ReplyModel();
                    });
                  },
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
