import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/service/message_service.dart';
import 'package:chat_app_flutter/service/user_service.dart';
import 'package:flutter/foundation.dart';

class MessageViewModel extends ChangeNotifier {
  final MessageService _messageService = MessageService();
  List<Message> messagOfGroup = [];
  List<Message> peerList = [];
  Future<void> getPeerMessage(String peerId) async {
    try {
      peerList = await _messageService.getPeerMessage(peerId);
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

  Future<void> addPeerMessage(Message message) async {
    peerList.add(message);
    notifyListeners();
  }

  void addMessageToMessageOfGroup(Message message) {
    messagOfGroup.add(message);
    notifyListeners();
  }
}




// Future<void> createPeerMessage(String senderId, String receiverId,
//       String senderName, String content) async {
//     try {
//       Message message = await _messageService.createPeerMessage(
//           senderId, receiverId, senderName, content);
//       peerList.add(message);
//       notifyListeners();
//     } on Exception catch (e) {
//       debugPrint(e.toString());
//     }
//   }