class ChatRoom {
  late String id;
  late String name;
  late int hostId;

  ChatRoom({id, name, hostId});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hostId = json['hostId'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['hostId'] = hostId;
    return data;
  }
}
