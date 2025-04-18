class ReplyModel {
  final String? messageId;
  final String? text;
  final String? userId;

  ReplyModel({
    this.messageId,
    this.text,
    this.userId,
  });
  @override
  String toString() => 'ReplyModel(text: $text)';
  factory ReplyModel.fromFirebase({
    required Map<String, dynamic> mapData,
  }) {
    return ReplyModel(
        text: mapData['text'],
        userId: mapData['userId'],
        messageId: mapData['messageId']);
  }
}
