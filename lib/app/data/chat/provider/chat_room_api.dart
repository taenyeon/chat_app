import 'dart:convert';

import 'package:chat_app/app/util/alert/snackbar_util.dart';
import 'package:chat_app/app/util/response/response.dart';
import 'package:chat_app/app/data/token/model/token.dart';
import 'package:chat_app/app/util/api/base_api.dart';
import 'package:dio/src/dio.dart';
import 'package:logging/logging.dart';

import '../model/chatRoom.dart';

class ChatRoomApi {
  final Logger log = Logger("UserApi");

  Future<Dio> getApi() async {
    var api = await baseApi();
    api.options.baseUrl = '${api.options.baseUrl}/chatRoom';
    return api;
  }

  Future<List<ChatRoom>> selectMyChatRoomList() async {
    var api = await getApi();
    var response = await api.get("/my");

    var data = ResponseData.fromJson(response.data);

    if (data.resultCode == 'SUCCESS') {
      var chatRoomList = data.body as List<dynamic>;
      return chatRoomList.map((e) => ChatRoom.fromJson(e)).toList();
    } else {
      SnackbarUtil.sendError("Load ChatRoom FAIL.");
      return Future.error("[ChatApi] selectMyChatRoomList FAIL.");
    }
  }

  selectMyChatRoomListTest() {
    List<ChatRoom> chatRoomList = [
      ChatRoom.fromJson({"id": "12345", "name": "test1", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test2", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test3", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test4", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test5", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test6", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test7", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test8", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test9", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test10", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "12345", "name": "test11", "hostId": 1}),
    ];

    return chatRoomList;
  }
}
