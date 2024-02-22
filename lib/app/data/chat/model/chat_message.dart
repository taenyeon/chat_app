class ChatMessage {
  late String id;
  late String roomId;
  late int memberId;
  late String payload;
  late DateTime issuedDateTime;

  ChatMessage({id, roomId, memberId, payload, issuedDateTime});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['roomId'];
    memberId = json['memberId'];
    payload = json['payload'];
    issuedDateTime = json['issuedDateTime'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['roomId'] = roomId;
    data['memberId'] = memberId;
    data['payload'] = payload;
    data['issuedDateTime'] = issuedDateTime;
    return data;
  }
}
