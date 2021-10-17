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
      var uri = Uri.http("$host:$port", getMessageIndividual, queryParams);
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
}
