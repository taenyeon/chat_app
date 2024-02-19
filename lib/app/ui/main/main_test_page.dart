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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: Row(
            children: [
              const MenuBar(),
              body(),
            ],
          ),
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
                Obx(
                  () => ListView.builder(
                    itemCount: menuController.menuList.length,
                    itemBuilder: (context, index) {
                      return menu(menuController.menuList[index]);
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10,
                    ),
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            ),
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
