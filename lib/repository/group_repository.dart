import 'dart:convert';
import 'dart:io';

import 'package:chat_app_flutter/apis/common.dart';
import 'package:chat_app_flutter/model/group_model.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroupRepository {
  Future<List<Group>> getAll() async {
    try {
      var uri = Uri.http("$host:$port", getAllGroup);
      var response = await http.get(uri,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        List<Group> list = [];
        (decodedResponse as List)
            .forEach((group) => list.add(Group.jsonFrom(group)));
        return list;
      }
      throw Exception();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
