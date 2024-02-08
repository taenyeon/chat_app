import 'package:chat_app/app/data/token/model/token.dart';
import 'package:chat_app/app/data/token/repository/token_repository.dart';
import 'package:chat_app/app/data/user/model/user.dart';
import 'package:chat_app/app/data/user/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class LoginController extends GetxController {
  late Logger log;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late UserRepository userRepository;
  late TokenRepository tokenRepository;

  RxBool isLogin = false.obs;
  late Rx<User> user = User().obs;

  @override
  void onInit() {
    log = Logger("LoginController");
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    userRepository = UserRepository();
    tokenRepository = TokenRepository();
    super.onInit();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    Token? token = await userRepository.login(
        usernameController.text, passwordController.text);
    if (token != null) {
      await tokenRepository.saveTokens(token.accessToken, token.refreshToken);
      Get.offAllNamed("/");
    }
  }
}
