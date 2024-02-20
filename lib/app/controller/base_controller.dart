import 'package:chat_app/app/data/user/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../data/user/model/user.dart';

class BaseController extends GetxController {
  late Logger log;
  late UserRepository userRepository;

  RxBool isLogin = false.obs;
  late Rx<User> user = User().obs;

  @override
  Future<void> onInit() async {
    log = Logger("MainController");
    userRepository = UserRepository();
    await loadUser();
    super.onInit();
  }

  loadUser() async {
    var user = await userRepository.getUserInfo();
    isLogin.value = true;
    this.user.value = user;
  }

  logout() async {
    await userRepository.logout();
    await Get.offAllNamed("/login");
  }
}
