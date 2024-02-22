import 'package:chat_app/app/data/chat/model/chat_room.dart';
import 'package:chat_app/app/data/chat/repository/chat_room_repository.dart';
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

  @override
  Future<void> onInit() async {
    log = Logger("chatRoomController");
    chatRoomRepository = ChatRoomRepository();
    await loadMyChatRoom();
    super.onInit();
  }

  loadMyChatRoom() async {
    chatRoomList.value = await chatRoomRepository.loadMyChatRoom();
  }

  void select(String id) async {
    if (selected.value != id) {
      selected.value = id;
      for (int i = 0; i < chatRoomList.length; i++) {
        var chatRoom = ChatRoom.fromJson(chatRoomList[i].toJson());
        if (chatRoom.id == id) {
          chatRoom.isSelected = true;
          selectedChatRoom = chatRoom.obs;
          chatRoom.backgroundColor = Colors.white30;
        } else {
          chatRoom.isSelected = false;
          chatRoom.backgroundColor = Colors.white12;
        }
        chatRoomList[i] = chatRoom;
      }
    }
    chatMessages.value = await chatRoomRepository.selectChatMessageList(id);
  }
}
