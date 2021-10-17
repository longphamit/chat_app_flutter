import 'dart:async';
import 'dart:io';

import 'package:chat_app_flutter/apis/common.dart';
import 'package:flutter/material.dart';

class SocketService {
  Socket? socket;
  Future<void> connect() async {
    Socket.connect(host, port).then((Socket sock) {
      socket = sock;
      socket?.listen(dataHandler,
          onDone: doneHandler, onError: errorHandler, cancelOnError: false);
    }).catchError((e) {
      debugPrint("Unable to connect: $e");
    });
    stdin.listen(
        (data) => socket?.write(String.fromCharCodes(data).trim() + '\n'));
  }

  void dataHandler(data) {
    debugPrint(String.fromCharCodes(data).trim());
  }

  void errorHandler(error, StackTrace trace) {
    debugPrint(error);
  }

  void doneHandler() {
    socket?.destroy();
  }
}