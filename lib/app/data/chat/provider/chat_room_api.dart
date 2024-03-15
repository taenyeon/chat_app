import 'package:chat_app/app/util/api/base_api.dart';
import 'package:chat_app/app/util/notify/snackbar_util.dart';
import 'package:chat_app/app/util/response/response.dart';
import 'package:dio/src/dio.dart';
import 'package:logging/logging.dart';

import '../../member/model/member.dart';
import '../model/chat_room.dart';

class ChatRoomApi {
  final Logger log = Logger("UserApi");

  Future<Dio> getApi() async {
    var api = await baseApi();
    api.options.baseUrl = '${api.options.baseUrl}/chatRoom';
    return api;
  }

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

  addChatRoom(String roomName, List<Member> selectedMembers) async {
    var api = await getApi();
    List<int> selectedMemberIds = selectedMembers.map((e) => e.id).toList();
    var response = await api.post("",
        data: {"roomName": roomName, "selectedMembers": selectedMemberIds});
  }
}
