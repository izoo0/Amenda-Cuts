import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/chat_home_model.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:amenda_cuts/Screens/chats/Pages/chat_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Common/Widget/Containers/chat_container.dart';
import '../../Models/users_model.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.blockSizeWidth!;
    Apis instance = Apis.instance;
    return NewAppBackground(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Consumer<UserDetailsProvider>(
          builder: (context, userDetailsProvider, _) {
        UsersModel userDetails = userDetailsProvider.usersModel;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            title: Row(
              children: [
                Container(
                  width: width * 8,
                  height: width * 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl: userDetails.profile ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text('Amenda Cuts',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  // .where('participant', arrayContains: user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                var chats = snapshot.data?.docs;
                List<Future<ChatHomeModel>> chatHomeModel =
                    chats!.map((docSnap) {
                  Map<String, dynamic> data = docSnap.data();
                  String docId = docSnap.id;

                  return ChatHomeModel.chatHomeData(
                      chatData: data,
                      chatId: docId,
                      context: context,
                      currentUser: instance.user!.uid);
                }).toList();

                return FutureBuilder<List<ChatHomeModel>>(
                    future: Future.wait(chatHomeModel),
                    builder: (context, snap) {
                      List<ChatHomeModel> chatData = snap.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: chatData.length,
                        itemBuilder: (context, index) {
                          final data = chatData[index];
                          return chatContainer(
                            chatModel: data,
                            context: context,
                            onTap: () {},
                          );
                        },
                      );
                    });
              }),
        );
      }),
    );
  }
}
