import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/service/user_service.dart';
import 'package:flutter/foundation.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = new UserService();
  List<User> friends = [
    User(id: "1", name: "Long"),
    User(id: "2", name: "Vinh")
  ];
  User? user;
  Future<void> login(String username, String password) async {
    try {
      user = await _userService.login(username, password);
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }
}
