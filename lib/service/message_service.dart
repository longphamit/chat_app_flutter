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
}
