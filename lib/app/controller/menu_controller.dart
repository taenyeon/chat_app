import 'package:chat_app/app/data/menu/model/MenuItems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../data/menu/model/MenuInfo.dart';

class MenuButtonsController extends GetxController {
  late Logger log;

  RxList<MenuInfo> menuList = <MenuInfo>[].obs;
  RxString selected = "".obs;

  @override
  void onInit() {
    log = Logger("MenuController");
    List<MenuInfo> list =
        MenuItems.values.map((e) => MenuInfo.fromJson(e.toJson())).toList();
    RxList<MenuInfo> menus = list.obs;
    menuList = menus;
    super.onInit();
  }

  void select(String name) {
    if (selected.value != name) {
      selected.value = name;
      for (int i = 0; i < menuList.length; i++) {
        var newMenu = MenuInfo.fromJson(menuList[i].toJson());
        if (newMenu.name == name) {
          newMenu.isSelected = true;
          newMenu.color = Colors.white70;
          newMenu.backgroundColor = Colors.white30;
        } else {
          newMenu.isSelected = false;
          newMenu.color = Colors.white38;
          newMenu.backgroundColor = Colors.white12;
        }
        menuList[i] = newMenu;
      }
    }
  }

  void selectMain() {
    selected.value = "main";

    for (int i = 0; i < menuList.length; i++) {
      var newMenu = MenuInfo.fromJson(menuList[i].toJson());
      newMenu.isSelected = false;
      newMenu.color = Colors.white38;
      newMenu.backgroundColor = Colors.white12;
      menuList[i] = newMenu;
    }
  }

  void clear() {
    selected.value = "";

    for (int i = 0; i < menuList.length; i++) {
      var newMenu = MenuInfo.fromJson(menuList[i].toJson());
      newMenu.isSelected = false;
      newMenu.color = Colors.white38;
      newMenu.backgroundColor = Colors.white12;
      menuList[i] = newMenu;
    }
  }
}
