import 'package:chat_app/app/controller/member_controller.dart';
import 'package:chat_app/app/controller/menu_controller.dart';
import 'package:chat_app/app/data/menu/model/MenuInfo.dart';
import 'package:chat_app/app/ui/chat/chat_page.dart';
import 'package:chat_app/app/ui/main/main_page.dart';
import 'package:chat_app/app/ui/main/profile_dialog.dart';
import 'package:chat_app/app/ui/web/web_mac_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../../controller/base_controller.dart';
import '../../util/color/color_list.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BaseController());
    Get.put(MemberController());
    var padding = const EdgeInsets.fromLTRB(0, 25, 0, 0);
    if (kIsWeb) padding = const EdgeInsets.all(0);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: padding,
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
            color: Colors.white.withOpacity(0.05),
          ),
          child: GetX<MenuButtonsController>(
            builder: (MenuButtonsController controller) {
              var selected = controller.selected.value;
              switch (selected) {
                case 'web':
                  return const WebMacPage();
                case 'chat':
                  return const ChatPage();
                case 'main':
                  return const MainPage();
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
    var mainController = Get.put(BaseController());
    return SizedBox(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.05),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildMainMenu(menuController),
                buildMenuList(menuController),
                buildExpanded(),
                buildUserPopup(mainController),
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
        width: 60,
        height: 60,
        child: IconButton(
          hoverColor: ColorList.none,
          highlightColor: ColorList.none,
          splashColor: ColorList.none,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.limeAccent),
          ),
          onPressed: () {
            menuController.selectMain();
          },
          icon: const Icon(
            Icons.rocket_launch,
            size: 40,
            shadows: [
              Shadow(
                color: Colors.lightBlue,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildUserPopup(BaseController mainController) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.limeAccent,
        ),
        width: 50,
        height: 50,
        child: PopupMenuButton<String>(
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
          onSelected: (String value) async {
            Logger("onSelectedTest").info("value : $value");
            switch (value) {
              case "Logout":
                await mainController.logout();
                break;
              case "Profile":
                await Get.dialog(const ProfileDialog());
                break;
              default:
            }
          },
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
                            color: Colors.black26,
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
                              GetX<BaseController>(
                                  builder: (BaseController controller) {
                                return Text(
                                  controller.user.value.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                              GetX<BaseController>(
                                  builder: (BaseController controller) {
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
                value: "Profile",
                child: Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem(
                value: "Settings",
                child: Text(
                  "Settings",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem(
                value: "Logout",
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
          child: Stack(
            children: [
              SizedBox(
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
                    menuController.select(menuInfo.name);
                  },
                  icon: menuInfo.icon,
                  color: Colors.white38,
                  iconSize: 25,
                ),
              ),
              if (menuInfo.hasNoti)
                Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
            ],
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
