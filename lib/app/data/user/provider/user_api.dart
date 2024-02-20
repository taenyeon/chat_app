import 'package:chat_app/app/util/response/response.dart';
import 'package:chat_app/app/data/token/model/token.dart';
import 'package:chat_app/app/data/user/model/user.dart';
import 'package:chat_app/app/util/api/base_api.dart';
import 'package:dio/src/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class UserApi {
  final Logger log = Logger("UserApi");

  Future<Dio> getApi() async {
    var api = await baseApi();
    api.options.baseUrl = '${api.options.baseUrl}/user';
    return api;
  }

  Future<Token?> login(String username, String password) async {
    var api = await getApi();
    var response = await api
        .post('/login', data: {'username': username, 'password': password});

    var data = ResponseData.fromJson(response.data);

    if (data.resultCode == 'SUCCESS') {
      Get.snackbar(
        "LOGIN",
        "SUCCESS",
        colorText: Colors.white,
      );
      return Token.fromJson(data.body);
    } else {
      Get.snackbar(
        "ERROR",
        "USER NOT FOUND",
        colorText: Colors.red,
      );
      return Future.error("[UserApi] login - USER NOT FOUND");
    }
  }

  Future<User> getUserInfo() async {
    try {
      var api = await getApi();
      var response = await api.get('');
      var data = ResponseData.fromJson(response.data);
      if (data.resultCode == 'SUCCESS') {
        return User.fromJson(data.body);
      } else {
        Get.snackbar("ERROR", "USER NOT FOUND");
        Get.offAllNamed("/login");
        return Future.error("[UserApi] getUserInfo - USER NOT FOUND");
      }
    } catch (e) {
      Get.snackbar("ERROR", "USER NOT FOUND");
      Get.offAndToNamed("/login");
      return Future.error("[UserApi] getUserInfo - USER NOT FOUND");
    }
  }
}
