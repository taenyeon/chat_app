import 'dart:convert';

import 'package:chat_app/app/util/response/Response.dart';
import 'package:chat_app/app/data/token/model/Token.dart';
import 'package:chat_app/app/data/user/model/User.dart';
import 'package:chat_app/app/util/api/base_api.dart';
import 'package:dio/src/dio.dart';
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
      return Token.fromJson(data.body);
    }
    return null;
  }

  Future<User?> getUserInfo() async {
    var api = await getApi();
    var response = await api.get('');
    var data = ResponseData.fromJson(response.data);
    if (data.resultCode == 'SUCCESS') {
      return User.fromJson(data.body);
    }
    return null;
  }
}
