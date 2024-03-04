import 'package:flutter/material.dart';

class MenuInfo {
  late String name;
  late String menuName;
  bool isSelected = false;
  Color backgroundColor = Colors.white12;
  Color color = Colors.white38;
  Icon icon = const Icon(
    Icons.abc,
    color: Colors.white38,
    size: 25,
  );

  bool hasNoti = false;

  MenuInfo(
    this.name,
    this.menuName,
    this.isSelected,
    this.color,
    this.icon,
    this.backgroundColor,
    this.hasNoti,
  );

  MenuInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    menuName = json['menuName'];
    isSelected = json['isSelected'];
    color = json['color'];
    icon = json['icon'];
    backgroundColor = json['backgroundColor'];
    hasNoti = false;
  }

  toJson() => <String, dynamic>{
        "name": name,
        'menuName': menuName,
        "isSelected": isSelected,
        "color": color,
        "icon": icon,
        "backgroundColor": backgroundColor,
        "hasNoti": hasNoti,
      };
}
