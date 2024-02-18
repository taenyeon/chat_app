import 'package:flutter/material.dart';

enum MenuItems {
  board(
    menuName: "BOARD",
    isSelected: true,
    color: Colors.white38,
    icon: Icon(Icons.text_snippet),
  ),
  chat(
    menuName: "CHAT",
    isSelected: true,
    color: Colors.white38,
    icon: Icon(Icons.chat),
  ),
  ;

  const MenuItems({
    required this.menuName,
    required this.isSelected,
    required this.color,
    required this.icon,
  });

  final String menuName;
  final bool isSelected;
  final Color color;
  final Icon icon;

  toJson() => <String, dynamic>{
        "name": name,
        'menuName': menuName,
        "isSelected": isSelected,
        "color": color,
        "icon": icon,
      };
}
