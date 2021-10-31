import 'package:chat_app_flutter/model/peer_model.dart';
import 'package:chat_app_flutter/service/peer_service.dart';
import 'package:flutter/foundation.dart';

class PeerViewModel extends ChangeNotifier {
  final PeerService _peerService = PeerService();
  List<Peer> listPeer = [];

  Future<void> getAll() async {
    try {
      listPeer = await _peerService.getAll();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
