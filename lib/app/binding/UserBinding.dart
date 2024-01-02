import 'package:chat_app/app/controller/UserController.dart';
import 'package:chat_app/app/data/user/provider/UserApi.dart';
import 'package:get/get.dart';

import '../data/user/repository/UserRepository.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() {
      return UserController(repository: UserRepository(userApi: UserApi()));
    });
  }
}
