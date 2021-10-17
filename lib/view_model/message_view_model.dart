import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/service/message_service.dart';
import 'package:chat_app_flutter/service/user_service.dart';
import 'package:flutter/foundation.dart';

class MessageViewModel extends ChangeNotifier {
  final MessageService _messageService = MessageService();
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

  List<Message> sortByTime() {
    List<Message> peer = [];
    peer.addAll(sender);
    peer.addAll(receiver);
    peer.sort((a, b) => a.time.compareTo(b.time));
    return peer;
  }
}
