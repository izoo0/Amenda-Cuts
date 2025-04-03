import 'package:cloud_firestore/cloud_firestore.dart';

class LastMessageModel {
  final String lastText;
  final DateTime messageTime;
  final List<String> deleted;
  final bool isDeleted;
  final String editedMessage;
  final bool isEdited;
  LastMessageModel({
    required this.lastText,
    required this.messageTime,
    required this.deleted,
    required this.isDeleted,
    required this.editedMessage,
    required this.isEdited,
  });
  factory LastMessageModel.fromFirebase(
      {required Map<String, dynamic> lastMessage}) {
    List<String> deletedUsers = [];

    final delete = lastMessage['deleted'];

    if (delete != null && delete is List) {
      for (var id in delete) {
        deletedUsers.add(id);
      }
    }
    var messageTime = DateTime(1980);
    final time = lastMessage['timestamp'];
    if (time is Timestamp) {
      messageTime = time.toDate();
    }
    return LastMessageModel(
      lastText: lastMessage['text_message'],
      messageTime: messageTime,
      deleted: deletedUsers,
      isDeleted: lastMessage['isDeleted'] ?? false,
      isEdited: lastMessage["isEdited"] ?? false,
      editedMessage: lastMessage['edited_message'] ?? "",
    );
  }
}
