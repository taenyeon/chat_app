import 'package:chat_app/app/data/token/model/Token.dart';
import 'package:chat_app/app/data/user/model/User.dart';
import 'package:get/get.dart';

import '../provider/UserApi.dart';

class UserRepository {
  final UserApi userApi = UserApi();

  RxBool isLogin = false.obs;
  late User user;

  Future<Token?> login(username, password) async =>
      await userApi.login(username, password);

  Future<User> getUserInfo() async => await userApi.getUserInfo();

  setUser(User user) => this.user = user;
}
