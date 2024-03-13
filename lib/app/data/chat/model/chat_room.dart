import 'dart:ui';

import 'package:chat_app/app/util/color/color_list.dart';
import 'package:flutter/material.dart';

class ChatRoom {
  String id = "";
  String name = "";
  late int hostId;

  bool isSelected = false;
  Color backgroundColor = ColorList.none;

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
