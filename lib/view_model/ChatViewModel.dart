import 'package:chat_app_flutter/model/Message.dart';
import 'package:chat_app_flutter/model/User.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart';

class ChatModel extends Model {
  List<User> users = [
    User('IronMan', '111'),
    User('Captain America', '222'),
    User('Antman', '333'),
    User('Hulk', '444'),
    User('Thor', '555'),
  ];
  User currentUser = User("name", "123");
  List<User> friendList = [];
  List<Message> messages = [];
  //late SocketIO socket;
  //late SocketIO socketIO;
  late Socket socket;
  void init() {
    currentUser = users[0];
    friendList = users.where((user) => user.id != currentUser.id).toList();
    socket = io('http://10.0.2.2:8080', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.emit('/test', 'test');
    print(socket.connected);
    // socket = SocketIOManager().createSocketIO(
    //     'http://192.168.96.1:3000', '/connection',
    //     query: 'chatID=${currentUser.id}');
    // socket.init();
    // socket.subscribe('receive_message', (jsonData) {
    //   Map<String, dynamic> data = json.decode(jsonData);
    //   messages.add(Message(data['content'], data['sender'], data['recipient']));
    //   notifyListeners();
    // });
    // socket.connect();
  }

  void sendMessage(String text, String recipient) {
    messages.add(Message(text, currentUser.id, recipient));
    // socket.on(
    //   'send_message',
    //   json.encode({
    //     'recipient': recipient,
    //     'sender': currentUser.id,
    //     'content': text,
    //   }),
    // );
    notifyListeners();
  }

  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.sender == chatID || msg.recipient == chatID)
        .toList();
  }
}
