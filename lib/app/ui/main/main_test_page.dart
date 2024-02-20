import 'package:chat_app/app/controller/user_popup_controller.dart';
import 'package:chat_app/app/data/menu/model/MenuInfo.dart';
import 'package:chat_app/app/ui/web/web_mac_page.dart';
import 'package:chat_app/app/ui/web/web_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/app/controller/menu_controller.dart';
import 'package:logging/logging.dart';

class MainTestPage extends StatelessWidget {
  const MainTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserPopupController userPopupController = Get.put(UserPopupController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: Row(
          children: [
            const MenuBar(),
            body(),
          ],
        ),
      ),
    );
  }

  Expanded body() {
    return Expanded(
      flex: 25,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white10,
          ),
          child: GetX<MenuButtonsController>(
            builder: (MenuButtonsController controller) {
              var selected = controller.selected.value;
              switch (selected) {
                case 'web':
                  return const WebPage();
                  break;
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class MenuBar extends StatelessWidget {
  const MenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    var menuController = Get.put(MenuButtonsController());
    return SizedBox(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white10,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildMainMenu(menuController),
                buildMenuList(menuController),
                buildExpanded(),
                popup(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Obx buildMenuList(MenuButtonsController menuController) {
    return Obx(
      () => ListView.builder(
        itemCount: menuController.menuList.length,
        itemBuilder: (context, index) {
          return menu(menuController.menuList[index]);
        },
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      child: Container(),
    );
  }

  Padding buildMainMenu(MenuButtonsController menuController) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: SizedBox(
        width: 50,
        height: 50,
        child: IconButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.limeAccent),
          ),
          onPressed: () {
            menuController.clear();
          },
          icon: const Icon(
            Icons.rocket_launch,
            shadows: [
              Shadow(
                color: Colors.lightBlue,
                offset: Offset(3, 3),
              ),
            ],
          ),
          iconSize: 40,
        ),
      ),
    );
  }

  Padding popup() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.limeAccent,
        ),
        width: 50,
        height: 50,
        child: PopupMenuButton(
          enabled: true,
          elevation: 2,
          surfaceTintColor: Colors.black,
          offset: const Offset(70, 0),
          tooltip: "",
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.black87,
          shadowColor: Colors.limeAccent,
          icon: const Icon(Icons.person),
          iconColor: Colors.black26,
          iconSize: 35,
          constraints: const BoxConstraints(
            minHeight: 200,
            minWidth: 200,
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                enabled: false,
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 10, 2),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.limeAccent,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetX<UserPopupController>(
                                  builder: (UserPopupController controller) {
                                return Text(
                                  controller.user.value.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                              GetX<UserPopupController>(
                                  builder: (UserPopupController controller) {
                                return Text(
                                  controller.user.value.createdAt,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const PopupMenuItem(
                child: Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem(
                child: Text(
                  "Settings",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem(
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ];
          },
        ),
      ),
    );
  }

  Column menu(MenuInfo menuInfo) {
    var menuController = Get.put(MenuButtonsController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: SizedBox(
            width: 50,
            height: 50,
            child: IconButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(menuInfo.backgroundColor),
                foregroundColor: MaterialStateProperty.all(menuInfo.color),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                Logger("test!!!").info("value : ${menuInfo.name}");
                menuController.select(menuInfo.name);
              },
              icon: menuInfo.icon,
              color: Colors.white38,
              iconSize: 25,
            ),
          ),
        ),
        Text(
          menuInfo.menuName,
          style: TextStyle(
            fontSize: 10,
            color: menuInfo.color,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
