// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
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

  void disconnect() {
    socket.disconnect();
  }
}
