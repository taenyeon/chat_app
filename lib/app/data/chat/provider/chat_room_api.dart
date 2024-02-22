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
      ChatRoom.fromJson({"id": "1", "name": "test1", "hostId": 1}),
      ChatRoom.fromJson({"id": "2", "name": "test2", "hostId": 1}),
      ChatRoom.fromJson({"id": "3", "name": "test3", "hostId": 1}),
      ChatRoom.fromJson({"id": "4", "name": "test4", "hostId": 1}),
      ChatRoom.fromJson({"id": "5", "name": "test5", "hostId": 1}),
      ChatRoom.fromJson({"id": "6", "name": "test6", "hostId": 1}),
      ChatRoom.fromJson({"id": "7", "name": "test7", "hostId": 1}),
      ChatRoom.fromJson({"id": "8", "name": "test8", "hostId": 1}),
      ChatRoom.fromJson({"id": "9", "name": "test9", "hostId": 1}),
      ChatRoom.fromJson({"id": "10", "name": "test10", "hostId": 1}),
      ChatRoom.fromJson({"id": "11", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "12", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "13", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "14", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "15", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "16", "name": "test11", "hostId": 1}),
      ChatRoom.fromJson({"id": "17", "name": "test11", "hostId": 1}),
    ];

    return chatRoomList;
  }

  List<ChatMessage> selectChatMessageListTest(String roomId) {
    List<ChatMessage> chatMessageList = [
      ChatMessage.fromJson({
        "id": "1",
        "roomId": "1",
        "memberId": 1,
        "payload": "hello",
        "issuedDateTime": DateTime.now()
      }),
      ChatMessage.fromJson({
        "id": "2",
        "roomId": "1",
        "memberId": 2,
        "payload": "hi!",
        "issuedDateTime": DateTime.now()
      }),
      ChatMessage.fromJson({
        "id": "3",
        "roomId": "1",
        "memberId": 1,
        "payload": "today is goodDay",
        "issuedDateTime": DateTime.now()
      }),
      ChatMessage.fromJson({
        "id": "4",
        "roomId": "1",
        "memberId": 2,
        "payload": "no... fuck you",
        "issuedDateTime": DateTime.now()
      }),
      ChatMessage.fromJson({
        "id": "5",
        "roomId": "1",
        "memberId": 1,
        "payload": "fuck you too",
        "issuedDateTime": DateTime.now()
      }),
      ChatMessage.fromJson({
        "id": "5",
        "roomId": "1",
        "memberId": 1,
        "payload": "your crazy",
        "issuedDateTime": DateTime.now()
      }),
      ChatMessage.fromJson({
        "id": "6",
        "roomId": "1",
        "memberId": 2,
        "payload": "by",
        "issuedDateTime": DateTime.now()
      }),
    ];
    return chatMessageList;
  }
}
