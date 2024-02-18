import 'package:chat_app/app/data/menu/model/MenuInfo.dart';
import 'package:chat_app/app/data/menu/model/MenuItems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/app/controller/menu_controller.dart';
import 'package:logging/logging.dart';

class MainTestPage extends StatelessWidget {
  const MainTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        children: [
          const MenuBar(),
          body(),
        ],
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
            color: Colors.white24,
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
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white24,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => ListView.builder(
                  itemCount: menuController.menuList.length,
                  itemBuilder: (context, index) {
                    return menu(menuController.menuList[index]);
                  },
                )),
          ),
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
                backgroundColor: MaterialStateProperty.all(Colors.white10),
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
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white38,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
