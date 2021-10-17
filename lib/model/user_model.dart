class User {
  late String id;
  late String name;
  User({this.id = "", this.name = ""});
  factory User.jsonFrom(Map<dynamic, dynamic> json) {
    return User(id: json["_id"], name: json["Name"]);
  }
}
