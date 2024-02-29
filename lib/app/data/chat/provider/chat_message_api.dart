import 'dart:convert';

import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/util/alert/snackbar_util.dart';
import 'package:chat_app/app/util/response/response.dart';
import 'package:chat_app/app/data/token/model/token.dart';
import 'package:chat_app/app/util/api/base_api.dart';
import 'package:dio/src/dio.dart';
import 'package:logging/logging.dart';

import '../model/chat_room.dart';

class ChatRoomApi {
  final Logger log = Logger("ChatMessageApi");

  Future<Dio> getApi() async {
    var api = await baseApi();
    api.options.baseUrl = '${api.options.baseUrl}/chat';
    return api;
  }

  getChatMessageByRoomId() {}

  Future<List<ChatRoom>> getMyChatRoomList() async {
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
}
