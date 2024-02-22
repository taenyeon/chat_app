import 'package:chat_app/app/data/chat/repository/chat_room_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class AddChatRoomController extends GetxController {
  late Logger log;
  late TextEditingController chatRoomNameController;

  late ChatRoomRepository chatRoomRepository;

  @override
  Future<void> onInit() async {
    log = Logger("chatRoomController");
    chatRoomRepository = ChatRoomRepository();
    super.onInit();
  }

  addChatRoom() {}
}
