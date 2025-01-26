class Message {
  final String message;
  final bool isCurrentUser;
  final String time;
  Message({
    required this.message,
    required this.isCurrentUser,
    required this.time,
  });
}

List<Message> messages = [
  Message(
    message: "Hello Word",
    isCurrentUser: true,
    time: "12:00",
  ),
  Message(
    message: "Hello me",
    isCurrentUser: false,
    time: "12:00",
  ),
  Message(
    message: "Hello there",
    isCurrentUser: true,
    time: "12:00",
  ),
  Message(
    message: "Hello World",
    isCurrentUser: false,
    time: "12:00",
  ),
  Message(
    message: "Hello there",
    isCurrentUser: true,
    time: "12:00",
  ),
  Message(
    message: "Hello",
    isCurrentUser: false,
    time: "12:00",
  ),
  Message(
    message:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
    isCurrentUser: true,
    time: "12:00",
  ),
];
