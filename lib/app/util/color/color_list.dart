import 'package:flutter/material.dart';

enum ColorList {
  background(color: Color(0xff1c1c1c)),
  menuBar(color: Colors.black12),
  menu(color: Colors.black26),
  ;

  const ColorList({
    required this.color,
  });

  final Color? color;

  toJson() => <String, dynamic>{
        "color": color,
      };
}
