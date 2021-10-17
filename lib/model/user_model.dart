class User {
  late String id;
  late String name;
  late String img;
  User({this.id = "", this.name = "", this.img = ""});
  factory User.jsonFrom(Map<dynamic, dynamic> json) {
    return User(id: json["id"], name: json["name"], img: json["img"]);
  }
}
