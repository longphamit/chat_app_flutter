import 'package:chat_app_flutter/model/group_model.dart';
import 'package:chat_app_flutter/service/group_service.dart';
import 'package:flutter/cupertino.dart';

class GroupViewModel extends ChangeNotifier {
  final GroupService _groupService = GroupService();
  Group user = Group();
  List<Group> listGroup = [];

  Future<void> getAll() async {
    try {
      listGroup = await _groupService.getAll();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
