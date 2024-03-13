class Member {
  late int id;
  late String username;
  late String name;
  late String phoneNumber;
  late String createdAt;
  late String updatedAt;
  String? imageUrl;

  Member({id, username, name, phoneNumber, createdAt, updatedAt});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
