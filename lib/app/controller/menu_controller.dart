import 'package:chat_app/app/data/menu/model/MenuItems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../data/menu/model/MenuInfo.dart';
import '../data/token/model/token.dart';

class MenuButtonsController extends GetxController {
  late Logger log;

  RxList<MenuInfo> menuList = <MenuInfo>[].obs;
  RxList<int> test = <int>[1, 2, 3].obs;
  RxList<Token> test2 = <Token>[
    Token.fromJson({"accessToken": "2134", "refreshToken": "335"})
  ].obs;

  @override
  void onInit() {
    log = Logger("menuController");
    List<MenuInfo> list =
        MenuItems.values.map((e) => MenuInfo.fromJson(e.toJson())).toList();
    RxList<MenuInfo> menus = list.obs;
    menuList = menus;
    log.info("menu : ${menus.toString()}");
    super.onInit();
  }

  void select(String name) {
    for (var menu in menuList) {
      if (menu.name == name) {
        log.info("selected Value : $name");
        menu.isSelected = true;
        menu.color = Colors.white;
      } else {
        menu.isSelected = false;
        menu.color = Colors.white38;
      }

      log.info("menu : ${menu.toJson()}");
    }
  }
}
