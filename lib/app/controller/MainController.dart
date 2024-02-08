import 'package:chat_app/app/data/user/repository/UserRepository.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../data/user/model/User.dart';

class MainController extends GetxController {
  late Logger log;
  late UserRepository userRepository;

  RxBool isLogin = false.obs;
  late Rx<User> user = User().obs;

  @override
  void onInit() {
    log = Logger("MainController");
    userRepository = UserRepository();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadUser() async {
    var user = await userRepository.getUserInfo();
    isLogin.value = true;
    this.user.value = user;
  }

  void logout() async {
    await userRepository.logout();
    isLogin.value = false;
    user.value = User();
  }
}
