class ChatMessage {
  late String? id;
  late String roomId;
  late int memberId;
  late String type;
  late String? payload;
  late int createdAt;

  ChatMessage({id, roomId, memberId, payload, issuedDateTime});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['roomId'];
    memberId = json['memberId'];
    payload = json['payload'];
    createdAt = json['createdAt'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['roomId'] = roomId;
    data['memberId'] = memberId;
    data['payload'] = payload;
    data['createdAt'] = createdAt;
    data['type'] = type;
    return data;
  }

  String toJsonString() {
    return "roomId:'$roomId',memberId:$memberId,payload:'$payload'";
  }
}
