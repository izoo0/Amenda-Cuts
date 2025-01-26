import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Chats/chat_interaction_sheet.dart';
import 'package:amenda_cuts/Models/message.dart';
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
            child: GroupedListView<Message, String>(
              elements: messages,
              groupSeparatorBuilder: (String groupByValue) =>
                  Text(groupByValue),
              groupBy: (messages) => messages.time,
              reverse: true,
              sort: false,
              itemBuilder: (context, Message msg) {
                return SwipeTo(
                  onRightSwipe: (details) {
                    setState(() {
                      replyMsg = msg.message;
                    });
                  },
                  child: Align(
                    alignment: msg.isCurrentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        chatInteractionSheet(
                          context: context,
                          message: msg.message,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: width * 80,
                            minWidth: width * 20,
                          ),
                          child: Card(
                            color: msg.isCurrentUser
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: msg.isCurrentUser
                                    ? const Radius.circular(10)
                                    : const Radius.circular(0),
                                topRight: const Radius.circular(10),
                                bottomLeft: const Radius.circular(10),
                                bottomRight: msg.isCurrentUser
                                    ? const Radius.circular(0)
                                    : const Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              child: Text(
                                msg.message,
                                style: msg.isCurrentUser
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(color: Colors.black)
                                    : Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 3,
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        if (replyMsg.isNotEmpty)
                          replyWidget(
                            name: "Isaiah",
                            context: context,
                            text: replyMsg,
                            onTap: () {
                              setState(() {
                                replyMsg = '';
                              });
                            },
                          ),
                        TextFormField(
                          minLines: 1,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.send_1),
                  ),
                )
              ],
            ),
          ),
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
