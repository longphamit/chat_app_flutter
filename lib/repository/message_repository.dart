import 'dart:convert';
import 'dart:io';

import 'package:chat_app_flutter/apis/common.dart';
import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessageRepository {
  Future<List<List<Message>>> getPeerMessage(
      String senderId, String receiverId) async {
    try {
      Map<String, String> queryParams = {
        'senderId': senderId,
        'receiverId': receiverId
      };
      var uri = Uri.https("$host", getMessageIndividual, queryParams);
      var response = await http.get(uri,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var sender = decodedResponse["sender"];
        var receiver = decodedResponse["receiver"];
        List<Message> senderList = [];
        List<Message> receiverList = [];
        List<List<Message>> peerList = [];
        if (sender != null) {
          (sender as List)
              .forEach((element) => senderList.add(Message.jsonFrom(element)));
        }
        if (receiver != null) {
          (receiver as List).forEach(
              (element) => receiverList.add(Message.jsonFrom(element)));
        }
        peerList.add(senderList);
        peerList.add(receiverList);
        return peerList;
      }
      throw Exception();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Message>> getGroupMessage(String groupId) async {
    try {
      Map<String, String> queryParams = {'receiverId': groupId};
      var uri = Uri.https("$host", getMessageByReceiverId, queryParams);
      var response = await http.get(uri,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var message = decodedResponse["message"];
        var receiver = decodedResponse["receiver"];
        List<Message> messageList = [];
        if (message != null) {
          (message as List)
              .forEach((element) => messageList.add(Message.jsonFrom(element)));
        }
        return messageList;
      }
      throw Exception();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Message> createMessage(String senderId, String receiverId,
      String senderName, String content) async {
    try {
      var data = {
        'senderId': senderId,
        'senderName': senderName,
        'receiverId': receiverId,
        'content': content
      };
      var bodyJson = jsonEncode(data);
      var uri = Uri.https("$host", createPeerMessage);
      var response = await http.post(uri,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: bodyJson);
      if (response.statusCode == 201) {
        var decodedResponse = jsonDecode(response.body) as Map;
        return Message.jsonFrom(decodedResponse);
      }
      throw Exception();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
