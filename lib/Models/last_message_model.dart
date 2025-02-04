import 'package:cloud_firestore/cloud_firestore.dart';

class LastMessageModel {
  final String lastText;
  final DateTime messageTime;

  LastMessageModel({
    required this.lastText,
    required this.messageTime,
  });
  @override
  String toString() =>
      'LastMessageModel(lastText: $lastText, messageTime: $messageTime)';
  factory LastMessageModel.fromFirebase(
      {required Map<String, dynamic> lastMessage}) {
    var messageTime = DateTime(1980);
    final time = lastMessage['timestamp'];
    if (time is Timestamp) {
      messageTime = time.toDate();
    }
    return LastMessageModel(
      lastText: lastMessage['text_message'],
      messageTime: messageTime,
    );
  }
}
