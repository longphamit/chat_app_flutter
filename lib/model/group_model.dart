import 'package:chat_app_flutter/model/user_model.dart';

class Group {
  late String id;
  late String name;
  late List<User> user;
  Group({this.id = "", this.name = ""});
  factory Group.jsonFrom(Map<dynamic, dynamic> json) {
    return Group(id: json["id"], name: json["name"]);
  }
}
