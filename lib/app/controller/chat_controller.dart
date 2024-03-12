import 'package:chat_app/app/controller/base_controller.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/chat/model/chat_room.dart';
import 'package:chat_app/app/data/chat/repository/chat_message_repository.dart';
import 'package:chat_app/app/data/chat/repository/chat_room_repository.dart';
import 'package:chat_app/app/util/chat/chat_client.dart';
import 'package:chat_app/app/util/color/color_list.dart';
import 'package:chat_app/app/util/time/time_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class ChatController extends GetxController {
  late Logger log;

  late ScrollController scrollController;

  late ChatRoomRepository chatRoomRepository;
  late ChatMessageRepository chatMessageRepository;

  RxString selected = "".obs;
  Rx<ChatRoom> selectedChatRoom = ChatRoom().obs;
  RxList chatRoomList = [].obs;
  RxList chatMessages = [].obs;

  RxMap<String, RxList<ChatMessage>> notiMessages =
      <String, RxList<ChatMessage>>{}.obs;

  RxBool goBottom = true.obs;

  late TextEditingController messagePayloadController;

  @override
  Future<void> onInit() async {
    log = Logger("chatRoomController");
    scrollController = ScrollController();
    chatRoomRepository = ChatRoomRepository();
    messagePayloadController = TextEditingController();
    chatMessageRepository = ChatMessageRepository();
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
      notiMessages[selected.value] = <ChatMessage>[].obs;
      await selectMessageByRoomId();
    }
  }

  void addTextNewLine() {
    messagePayloadController.text = "${messagePayloadController.text}\n";
  }

  selectMessageByRoomId() async {
    var roomId = selectedChatRoom.value.id;
    chatMessages.value =
        await chatMessageRepository.getChatMessageByRoomId(roomId);
  }

  addMessage(ChatMessage chatMessage) {
    log.info("addMessage");
    chatMessages.value = [...chatMessages, chatMessage];
    goBottom.value = true;
    // goUnder();
  }

  addNotiMessage(ChatMessage chatMessage) {
    log.info("addNotiMessage");
    notiMessages[chatMessage.roomId] = [
      ...?notiMessages[chatMessage.roomId],
      chatMessage,
    ].obs;
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
      "type": "TEXT",
      "createdAt": DateTime.now().millisecondsSinceEpoch
    });

    ChatClient.send(message);

    messagePayloadController.text = "";
  }

  void sendFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null)
      chatMessageRepository.sendFile(selectedChatRoom.value.id, result);
  }

  void goUnder() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 5), curve: Curves.easeInOutSine);
  }
}
