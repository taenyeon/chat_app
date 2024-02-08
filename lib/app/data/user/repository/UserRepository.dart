import 'package:chat_app/app/data/token/model/Token.dart';
import 'package:chat_app/app/data/token/repository/TokenRepository.dart';
import 'package:chat_app/app/data/user/model/User.dart';
import 'package:chat_app/app/util/storage/Storage.dart';
import 'package:get/get.dart';

import '../provider/UserApi.dart';

class UserRepository {
  final UserApi userApi = UserApi();
  final TokenRepository tokenRepository = TokenRepository();
  Future<Token?> login(username, password) async =>
      await userApi.login(username, password);

  logout() async {
    await tokenRepository.dropTokens();
  }

  Future<User> getUserInfo() async => await userApi.getUserInfo();
}
