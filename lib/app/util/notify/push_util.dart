import 'package:chat_app/app/controller/chat_controller.dart';
import 'package:chat_app/app/controller/member_controller.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:get/get.dart';
import 'package:local_notifier/local_notifier.dart';

import '../../data/chat/model/chat_room.dart';

class PushUtil {
  static void sendLocalPush(ChatMessage message) {
    if (message.type == "FILE") {
      message.payload = "Member Send File";
    }
    var chatController = Get.put(ChatController());
    var roomName = "";

    for (int i = 0; i < chatController.chatRoomList.length; i++) {
      var chatRoom = ChatRoom.fromJson(chatController.chatRoomList[i].toJson());
      roomName = chatRoom.name;
    }

    var memberController = Get.put(MemberController());

    var member = memberController.memberMap[message.memberId];
    var memberName = member?.name;
    var localNotification = LocalNotification(
      title: roomName,
      subtitle: memberName,
      body: message.payload,
    );

    localNotification.show();
  }
}
