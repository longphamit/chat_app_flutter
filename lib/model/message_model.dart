class Message {
  late String content;
  late String senderId;
  late String receiverId;
  Message({this.content = "", this.senderId = "", this.receiverId = ""});
  factory Message.jsonFrom(Map<dynamic, dynamic> json) {
    return Message(
        content: json["content"],
        senderId: json["senderId"],
        receiverId: json["receiverId"]);
  }
}
