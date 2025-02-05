import 'package:amenda_cuts/Models/reply_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatModel {
  final List<String> favorite;
  final ReplyModel replyTo;
  final String textMessage;
  final DateTime time;
  final String userId;
  final String messageId;
  ChatModel(
      {required this.favorite,
      required this.replyTo,
      required this.textMessage,
      required this.time,
      required this.messageId,
      required this.userId});
  @override
  String toString() => "ChatModel( replyTo: $replyTo,)";
  factory ChatModel.fromFirebase(
      {required Map<String, dynamic> msgData, required String msgId}) {
    List<String> newFavorite = [];
    final favorites = msgData['favorite'];
    User? user = FirebaseAuth.instance.currentUser;
    if (favorites != null && favorites is List) {
      for (var id in favorites) {
        newFavorite.add(id);
      }
    }
    DateTime msgTime = DateTime(1950);
    var newTime = msgData['timestamp'];
    if (newTime != null && newTime is Timestamp) {
      msgTime = newTime.toDate();
    }
    ReplyModel reply = ReplyModel();
    dynamic replyMsg = msgData['replyTo'];
    if (replyMsg != null && replyMsg is Map) {
      Map<String, dynamic> map = replyMsg as Map<String, dynamic>;
      reply = ReplyModel.fromFirebase(mapData: map);
    }
    return ChatModel(
        favorite: newFavorite,
        replyTo: reply,
        textMessage: msgData['text_message'],
        time: msgTime,
        userId: msgData['user_id'],
        messageId: msgId);
  }
}
