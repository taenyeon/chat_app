import 'package:chat_app/app/data/token/model/Token.dart';
import 'package:chat_app/app/data/user/model/User.dart';

import '../provider/UserApi.dart';

class UserRepository {
  final UserApi userApi = UserApi();

  Future<Token?> login(username, password) async =>
      await userApi.login(username, password);

  Future<User?> getUserInfo() async => await userApi.getUserInfo();
}
