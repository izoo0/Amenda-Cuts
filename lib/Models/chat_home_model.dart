import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/last_message_model.dart';
import 'package:amenda_cuts/Models/other_users_model.dart';
import 'package:amenda_cuts/Provider/other_user_details_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHomeModel {
  final String userName;
  final String profile;
  LastMessageModel lastMessageModel;
  final int counts;
  final String chatId;
  final String otherUserId;
  ChatHomeModel({
    required this.userName,
    required this.counts,
    required this.lastMessageModel,
    required this.profile,
    required this.chatId,
    required this.otherUserId,
  });
  @override
  toString() =>
      'ChatHomeModel(userName: $userName, counts: $counts, lastMessageModel: $lastMessageModel, profile: $profile, chatId: $chatId, otherUserId: $otherUserId)';
  static Future<ChatHomeModel> chatHomeData(
      {required Map<String, dynamic> chatData,
      required String chatId,
      required BuildContext context,
      required String currentUser}) async {
    Apis instance = Apis.instance;
    final lastMessageId = chatData['last_message_id'] ?? '';

    LastMessageModel lastMessageModel = LastMessageModel(
      lastText: '',
      messageTime: DateTime(1850),
    );
    if (lastMessageId is String) {
      DocumentSnapshot snapshot = await instance.firestore
          .collection("messages")
          .doc(chatId)
          .collection("chats")
          .doc(lastMessageId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> lastMessage =
            snapshot.data() as Map<String, dynamic>;

        lastMessageModel =
            LastMessageModel.fromFirebase(lastMessage: lastMessage);
      }
    }

    int unreadCount = 0;
    final unread = chatData['unreadCount'];

    if (unread is Map) {
      var count = unread[currentUser];
      if (count is num) {
        unreadCount = count.toInt();
      }
    }

    String name = '';
    String profilePic = '';
    String otherParty = '';
    OtherUserDetailsProvider otherUserDetailsProvider =
        Provider.of<OtherUserDetailsProvider>(context, listen: false);
    List<OtherUsersModel> users = otherUserDetailsProvider.otherUserModel;
    final parts = chatData['participant'] ?? [];
    print("___________________________${chatData["participant"]}");
    if (parts.length > 1) {
      List<String> allParties = [];

      otherParty = parts.firstWhere((id) => id != currentUser);
      var otherUserP = users.any((user) => user.otherUserId == otherParty);

      if (otherUserP) {
        var newUserDetails =
            users.firstWhere((user) => user.otherUserId == otherParty);
        name = newUserDetails.name ?? '';
        profilePic = newUserDetails.profile ?? '';
      }
    }
    return ChatHomeModel(
      userName: name,
      counts: unreadCount,
      lastMessageModel: lastMessageModel,
      profile: profilePic,
      chatId: chatId,
      otherUserId: otherParty,
    );
  }
}
