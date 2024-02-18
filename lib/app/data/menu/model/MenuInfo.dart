import 'package:flutter/material.dart';

class MenuInfo {
  late String name;
  late String menuName;
  bool isSelected = false;
  Color color = Colors.white38;
  Icon icon = const Icon(Icons.abc);

  MenuInfo(
    this.name,
    this.menuName,
    this.isSelected,
    this.color,
    this.icon,
  );

  MenuInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    menuName = json['menuName'];
    isSelected = json['isSelected'];
    color = json['color'];
    icon = json['icon'];
  }

  toJson() => <String, dynamic>{
        "name": name,
        'menuName': menuName,
        "isSelected": isSelected,
        "color": color,
        "icon": icon,
      };
}
