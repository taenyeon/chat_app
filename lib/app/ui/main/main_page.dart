import 'package:chat_app/app/controller/main_controller.dart';
import 'package:chat_app/app/data/token/repository/token_repository.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.put(MainController());
    mainController.loadUser();
    final TokenRepository tokenRepository = TokenRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main'),
      ),
      body: Column(
        children: [
          GetX<MainController>(builder: (MainController controller) {
            return Center(
              child: Text(
                "isLogin : ${mainController.isLogin.value}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }),
          GetX<MainController>(builder: (MainController controller) {
            if (mainController.isLogin.value) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      "USER : ${mainController.user.value.toJson()}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.limeAccent,
                      ),
                      onPressed: () => Get.toNamed("/mainTest"),
                      child: const Text(
                        "MAIN TEST",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => mainController.logout(),
                      child: const Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.limeAccent,
                      ),
                      onPressed: () => Get.offAllNamed("/login"),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.limeAccent,
                      ),
                      onPressed: () => tokenRepository.dropTokens(),
                      child: const Text(
                        "CLEAR",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          })
        ],
      ),
    );
  }
}
