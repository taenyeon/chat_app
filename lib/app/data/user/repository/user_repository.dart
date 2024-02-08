import 'package:chat_app/app/data/token/model/token.dart';
import 'package:chat_app/app/data/token/repository/token_repository.dart';
import 'package:chat_app/app/data/user/model/user.dart';

import '../provider/user_api.dart';

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
