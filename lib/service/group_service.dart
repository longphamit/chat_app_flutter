import 'package:chat_app_flutter/model/group_model.dart';
import 'package:chat_app_flutter/repository/group_repository.dart';

class GroupService {
  final GroupRepository _groupRepository = GroupRepository();

  Future<List<Group>> getAll() async {
    try {
      return await _groupRepository.getAll();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
