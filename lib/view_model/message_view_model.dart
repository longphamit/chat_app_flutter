import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/service/message_service.dart';
import 'package:chat_app_flutter/service/user_service.dart';
import 'package:flutter/foundation.dart';

class MessageViewModel extends ChangeNotifier {
  final MessageService _messageService = MessageService();
  List<Message> messagOfGroup = [];
  List<Message> sender = [];
  List<Message> receiver = [];
  Future<void> getPeerMessage(String senderId, String receiverId) async {
    try {
      List<List<Message>> peerList =
          await _messageService.getPeerMessage(senderId, receiverId);
      sender = peerList[0];
      receiver = peerList[1];
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getGroupMessage(String groupId) async {
    try {
      messagOfGroup = await _messageService.getGroupMessage(groupId);
      messagOfGroup.sort((a, b) => a.time.compareTo(b.time));
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  List<Message> sortByTime() {
    List<Message> peer = [];
    peer.addAll(sender);
    peer.addAll(receiver);
    peer.sort((a, b) => a.time.compareTo(b.time));
    return peer;
  }

  Future<void> createPeerMessage(String senderId, String receiverId,
      String senderName, String content) async {
    try {
      Message message = await _messageService.createPeerMessage(
          senderId, receiverId, senderName, content);
      sender.add(message);
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void addMessageToMessageOfGroup(Message message) {
    messagOfGroup.add(message);
    notifyListeners();
  }
}
