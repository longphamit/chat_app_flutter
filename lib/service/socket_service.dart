// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:chat_app_flutter/model/message_model.dart';
import 'package:chat_app_flutter/view_model/message_view_model.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class SocketService {
  late IO.Socket socket;
  IO.Socket connect(String host, int port) {
    socket = IO.io("http://${host}:${port}", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    return socket;
  }

  IO.Socket connectGroup(String host, String group, var context) {
    socket = IO.io("${host}", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'query': {"chatID": group}
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on(
        'GROUP_MESSAGE',
        (data) => Provider.of<MessageViewModel>(context, listen: false)
            .addMessageToMessageOfGroup(Message.jsonFrom(data)));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    return socket;
  }

  void disconnect() {
    socket.disconnect();
  }
}
