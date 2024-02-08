import 'package:chat_app/app/controller/MainController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.put(MainController());
    mainController.loadUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main'),
      ),
      body: Column(
        children: [
          GetX<MainController>(builder: (MainController controller) {
            return Center(
              child: Text("isLogin : ${mainController.isLogin.value}"),
            );
          }),
          GetX<MainController>(builder: (MainController controller) {
            if (mainController.isLogin.value) {
              return Column(
                children: [
                  Center(
                    child: Text("USER : ${mainController.user.value}"),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => mainController.logout(),
                      child: const Text("LOGOUT"),
                    ),
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Get.offAllNamed("/login"),
                      child: const Text("LOGIN"),
                    ),
                  )
                ],
              );
            }
          })
        ],
      ),
    );
  }
}
