import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/util/response/response.dart';
import 'package:chat_app/app/util/api/base_api.dart';
import 'package:dio/src/dio.dart';
import 'package:logging/logging.dart';

class ChatMessageApi {
  final Logger log = Logger("ChatMessageApi");

  Future<Dio> getApi() async {
    var api = await baseApi();
    api.options.baseUrl = '${api.options.baseUrl}/chat';
    return api;
  }

  Future<List<ChatMessage>> getChatMessageByRoomId(String roomId) async {
    var api = await getApi();
    var response = await api.get("/$roomId");

    var data = ResponseData.fromJson(response.data);

    if (data.resultCode == 'SUCCESS') {
      var chatMessageList = data.body as List;
      return chatMessageList.map((e) => ChatMessage.fromJson(e)).toList();
    } else {
      return Future.error("[ChatApi] API getChatMessageByRoomId FAIL");
    }
  }
}
