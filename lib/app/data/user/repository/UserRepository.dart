import '../provider/UserApi.dart';

class UserRepository {
  final UserApi userApi;

  UserRepository({required this.userApi});

  login(username, password) async => userApi.login(username, password);

  getUserInfo() async => userApi.getUserInfo();
}
