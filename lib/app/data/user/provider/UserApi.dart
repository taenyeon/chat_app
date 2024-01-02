import 'dart:convert';

import 'package:chat_app/app/data/user/model/Token.dart';
import 'package:chat_app/app/data/user/model/User.dart';
import 'package:chat_app/app/util/api/base_api.dart';
import 'package:dio/src/dio.dart';

class UserApi {
  Future<Dio> getApi() async {
    var api = await baseApi();
    api.options.baseUrl = '${api.options.baseUrl}/user';
    return api;
  }

  login(String username, String password) async {
    var api = await getApi();
    var response = await api
        .post('/login', data: {'username': username, 'password': password});
    var data = response.data;
    if (data.resultCode == 'SUCCESS') {
      return Token.fromJson(json.decode(data.body));
    }
  }

  getUserInfo() async {
    var api = await getApi();
    var response = await api.get('');
    var data = response.data;
    if (data.resultCode == 'SUCCESS') {
      return User.fromJson(json.decode(data.body));
    }
  }
}
