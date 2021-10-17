import 'dart:convert';
import 'dart:io';

import 'package:chat_app_flutter/apis/common.dart';
import 'package:chat_app_flutter/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<User> getUserInfo(String username, String password) async {
    try {
      Map<String, String> queryParams = {
        'username': username,
        'password': password
      };
      var uri = Uri.http("$host:$port", getUserInfoApi, queryParams);
      var response = await http.get(uri,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return User.jsonFrom(decodedResponse);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
