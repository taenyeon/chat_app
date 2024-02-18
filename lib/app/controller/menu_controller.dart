import 'package:chat_app/app/data/menu/model/MenuItems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../data/menu/model/MenuInfo.dart';
import '../data/token/model/token.dart';

class MenuButtonsController extends GetxController {
  late Logger log;

  RxList<MenuInfo> menuList = <MenuInfo>[].obs;

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
    for (int i = 0; i < menuList.length; i++) {
      log.info("menuList length : ${menuList.length}");
      log.info("for i : $i");
      var newMenu = MenuInfo.fromJson(menuList[i].toJson());
      if (newMenu.name == name) {
        log.info("selected Value : $name");
        newMenu.isSelected = true;
        newMenu.color = Colors.white;
      } else {
        newMenu.isSelected = false;
        newMenu.color = Colors.white38;
      }
      menuList[i] = newMenu;
    }
    // for (var menu in menuList) {
    //   if (menu.name == name) {
    //     log.info("selected Value : $name");
    //     menu.isSelected = true;
    //     menu.color = Colors.white;
    //   } else {
    //     menu.isSelected = false;
    //     menu.color = Colors.white38;
    //   }
    //
    //   log.info("menu : ${menu.toJson()}");
    // }
  }
}
