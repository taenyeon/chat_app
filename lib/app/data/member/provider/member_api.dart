import 'package:chat_app/app/data/member/model/member.dart';
import 'package:chat_app/app/util/alert/snackbar_util.dart';
import 'package:chat_app/app/util/response/response.dart';
import 'package:chat_app/app/data/token/model/token.dart';
import 'package:chat_app/app/data/user/model/user.dart';
import 'package:chat_app/app/util/api/base_api.dart';
import 'package:dio/src/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class MemberApi {
  final Logger log = Logger("MemberApi");

  Future<Dio> getApi() async {
    var api = await baseApi();
    api.options.baseUrl = '${api.options.baseUrl}/member';
    return api;
  }

  Future<List<Member>> getMemberList() async {
    var api = await getApi();
    var response = await api.get('');
    var data = ResponseData.fromJson(response.data);
    if (data.resultCode == 'SUCCESS') {
      List body = data.body;
      return body.map((e) => Member.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
