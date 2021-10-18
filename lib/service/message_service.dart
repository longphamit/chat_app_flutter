import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/repository/message_repository.dart';
import 'package:chat_app_flutter/repository/user_repository.dart';

class MessageService {
  final MessageRepository _messageRepository = MessageRepository();
  Future<List<List<Message>>> getPeerMessage(
      String senderId, String receiverId) async {
    try {
      return await _messageRepository.getPeerMessage(senderId, receiverId);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Message>> getGroupMessage(String groupId) async {
    try {
      return await _messageRepository.getGroupMessage(groupId);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Message> createPeerMessage(String senderId, String receiverId,
      String senderName, String content) async {
    try {
      return await _messageRepository.createMessage(
          senderId, receiverId, senderName, content);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
