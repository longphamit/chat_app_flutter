class Group {
  late String id;
  late String name;
  late List<String>? users;
  Group({this.id = "", this.name = "", this.users});
  factory Group.jsonFrom(Map<dynamic, dynamic> json) {
    List<String> stringList = (json["Member"] as List<dynamic>).cast<String>();
    return Group(id: json["_id"], name: json["Name"], users: stringList);
  }
}
