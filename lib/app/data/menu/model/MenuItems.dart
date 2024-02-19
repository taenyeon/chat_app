import 'package:flutter/material.dart';

enum MenuItems {
  board(
    menuName: "BOARD",
    isSelected: true,
    color: Colors.white38,
    backgroundColor: Colors.white12,
    icon: Icon(Icons.text_snippet),
  ),
  chat(
    menuName: "CHAT",
    isSelected: true,
    color: Colors.white38,
    backgroundColor: Colors.white12,
    icon: Icon(Icons.chat),
  ),
  ;

  const MenuItems({
    required this.menuName,
    required this.isSelected,
    required this.color,
    required this.icon,
    required this.backgroundColor,
  });

  final String menuName;
  final bool isSelected;
  final Color color;
  final Icon icon;
  final Color backgroundColor;

  toJson() => <String, dynamic>{
        "name": name,
        'menuName': menuName,
        "isSelected": isSelected,
        "color": color,
        "backgroundColor": backgroundColor,
        "icon": icon,
      };
}
