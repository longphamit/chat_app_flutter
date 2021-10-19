class Peer {
  late String id;
  late List<String>? names;
  late List<String>? users;
  Peer({this.id = "", this.names, this.users});
  factory Peer.jsonFrom(Map<dynamic, dynamic> json) {
    List<String> stringList = (json["Member"] as List<dynamic>).cast<String>();
    List<String> nameReceiver =
        (json["NameReceiver"] as List<dynamic>).cast<String>();
    return Peer(id: json["_id"], names: nameReceiver, users: stringList);
  }
}
