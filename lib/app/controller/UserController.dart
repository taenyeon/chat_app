import 'package:chat_app/app/data/user/model/Token.dart';
import 'package:chat_app/app/data/user/model/User.dart';
import 'package:chat_app/app/data/user/repository/UserRepository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final UserRepository repository;

  UserController({required this.repository});

  final _user = User().obs;

  get user => _user.value;

  set user(value) => _user.value = value;

  login(username, password) async {
    var flutterSecureStorage = const FlutterSecureStorage();
    Token tokens = await repository.login(username, password);
    await flutterSecureStorage.write(
        key: 'accessToken', value: tokens.accessToken);
    await flutterSecureStorage.write(
        key: 'refreshToken', value: tokens.refreshToken);

    User userInfo = await repository.getUserInfo();

    var sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('userInfo', userInfo.toString());
    _user.value = user;
  }
}
