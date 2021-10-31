import 'package:chat_app_flutter/model/user_model.dart';
import 'package:chat_app_flutter/repository/user_repository.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();
  Future<User> login(String username, String password) async {
    try {
      return await _userRepository.getUserInfo(username, password);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<User>> getAllUser() async {
    try {
      return await _userRepository.getAllUser();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
