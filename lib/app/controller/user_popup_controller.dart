import 'package:chat_app/app/data/menu/model/MenuItems.dart';
import 'package:chat_app/app/data/user/model/user.dart';
import 'package:chat_app/app/data/user/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../data/menu/model/MenuInfo.dart';
import '../data/token/model/token.dart';

class UserPopupController extends GetxController {
  late Logger log;
  late UserRepository userRepository;

  Rx<User> user = User().obs;

  @override
  void onInit() async {
    log = Logger("menuController");
    userRepository = UserRepository();
    user.value = await userRepository.getUserInfo();
    super.onInit();
  }
}
