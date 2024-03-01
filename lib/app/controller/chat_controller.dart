import 'package:chat_app/app/controller/base_controller.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/chat/model/chat_room.dart';
import 'package:chat_app/app/data/chat/repository/chat_room_repository.dart';
import 'package:chat_app/app/util/chat/chat_client.dart';
import 'package:chat_app/app/util/color/color_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class ChatController extends GetxController {
  late Logger log;
  late ChatRoomRepository chatRoomRepository;

  RxString selected = "".obs;
  Rx<ChatRoom> selectedChatRoom = ChatRoom().obs;
  RxList chatRoomList = [].obs;
  RxList chatMessages = [].obs;

  late TextEditingController messagePayloadController;

  @override
  Future<void> onInit() async {
    log = Logger("chatRoomController");
    chatRoomRepository = ChatRoomRepository();
    messagePayloadController = TextEditingController();
    await loadMyChatRoom();
    super.onInit();
  }

  loadMyChatRoom() async {
    chatRoomList.value = await chatRoomRepository.getMyChatRoomList();
  }

  void selectChatRoom(String id) async {
    if (selected.value != id) {
      selected.value = id;
      for (int i = 0; i < chatRoomList.length; i++) {
        var chatRoom = ChatRoom.fromJson(chatRoomList[i].toJson());
        if (chatRoom.id == id) {
          chatRoom.isSelected = true;
          selectedChatRoom.value = chatRoom;
          chatRoom.backgroundColor = ColorList.none;
        } else {
          chatRoom.isSelected = false;
          chatRoom.backgroundColor = ColorList.buttonColor;
        }
        chatRoomList[i] = chatRoom;
      }
    }
  }

  void addTextNewLine() {
    messagePayloadController.text = "${messagePayloadController.text}\n";
  }

  void sendMessage() {
    var userController = Get.put(BaseController());
    var payload = messagePayloadController.text;
    if (payload == "") {
      return;
    }
    var message = ChatMessage.fromJson({
      "roomId": selectedChatRoom.value.id,
      "memberId": userController.user.value.id,
      "payload": payload,
      "createdAt": DateTime.now().millisecond,
    });

    ChatClient.send(message);
    messagePayloadController.text = "";
  }
}
