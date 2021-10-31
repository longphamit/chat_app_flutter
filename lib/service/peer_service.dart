import 'package:chat_app_flutter/model/peer_model.dart';
import 'package:chat_app_flutter/repository/peer_repository.dart';

class PeerService {
  final PeerRepository _peerRepository = PeerRepository();
  Future<List<Peer>> getAll() async {
    try {
      return await _peerRepository.getAll();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
