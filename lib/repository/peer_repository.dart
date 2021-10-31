import 'dart:convert';
import 'dart:io';

import 'package:chat_app_flutter/apis/common.dart';
import 'package:chat_app_flutter/model/peer_model.dart';
import 'package:http/http.dart' as http;

class PeerRepository {
  Future<List<Peer>> getAll() async {
    try {
      var uri = Uri.http("$host", getAllPeer);
      var response = await http.get(uri,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        List<Peer> list = [];
        (decodedResponse as List)
            .forEach((peer) => list.add(Peer.jsonFrom(peer)));
        return list;
      }
      throw Exception();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
