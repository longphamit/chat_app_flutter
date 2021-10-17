class Message {
  late String content;
  late String senderId;
  late String receiverId;
  late DateTime time;
  Message(
      {this.content = "",
      this.senderId = "",
      this.receiverId = "",
      required this.time});
  factory Message.jsonFrom(Map<dynamic, dynamic> json) {
    return Message(
        content: json["Content"],
        senderId: json["SenderId"],
        receiverId: json["ReceiverId"],
        time: DateTime.parse(json["CreateDate"]));
  }
}
