import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app_flutter/service/socket_service.dart';
import 'package:flutter/cupertino.dart';

class SocketChat extends ChangeNotifier {
  IO.Socket? socket;
  SocketService _socketService = SocketService();
  Future<void> connectToServer(String host, int port) async {
    try {
      await _socketService.connect(host, port);
      socket = _socketService.socket;
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
