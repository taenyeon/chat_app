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
  RxInt chatRoomPage = 0.obs;

  RxMap<String, RxList<ChatMessage>> notiMessages =
      <String, RxList<ChatMessage>>{}.obs;

  RxBool goBottom = true.obs;

  late TextEditingController messagePayloadController;

  @override
  Future<void> onInit() async {
    log = Logger("chatRoomController");
    scrollController = ScrollController();

    scrollController.addListener(isTop);

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
          chatRoom.backgroundColor = ColorList.buttonColor;
        } else {
          chatRoom.isSelected = false;
          chatRoom.backgroundColor = ColorList.none;
        }
        chatRoomList[i] = chatRoom;
      }
      notiMessages[selected.value] = <ChatMessage>[].obs;
      chatRoomPage.value = 0;
      await selectMessageByRoomId();
    }
  }

  void addTextNewLine() {
    messagePayloadController.text = "${messagePayloadController.text}\n";
  }

  selectMessageByRoomId() async {
    var roomId = selectedChatRoom.value.id;
    List<ChatMessage> list = await chatMessageRepository.getChatMessageByRoomId(
        roomId, chatRoomPage.value);
    chatMessages.value = [...list.reversed, ...chatMessages];
  }

  addMessage(ChatMessage chatMessage) {
    chatMessages.value = [...chatMessages, chatMessage];
    goBottom.value = true;
  }

  addNotiMessage(ChatMessage chatMessage) {
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

    if (result != null) {
      chatMessageRepository.sendFile(selectedChatRoom.value.id, result);
    }
  }

  void goUnder() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 5), curve: Curves.easeInOutSine);
  }

  void isTop() async {
    if (scrollController.offset == 0) {
      chatRoomPage.value++;
      await selectMessageByRoomId();
      scrollController.jumpTo(scrollController.offset + 100);
    }
  }
}
