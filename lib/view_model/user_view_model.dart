import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/service/user_service.dart';
import 'package:flutter/foundation.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  User? user;
  Future<int> login(String username, String password) async {
    try {
      user = await _userService.login(username, password);
      notifyListeners();
      if (user != null) return 1;
      return 0;
    } on Exception catch (e) {
      user = null;
      return 0;
    }
  }
}
