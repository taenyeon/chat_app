import 'package:chat_app/app/controller/chat_controller.dart';
import 'package:chat_app/app/data/chat/model/chat_room.dart';
import 'package:chat_app/app/util/color/color_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_page_v3.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          color: ColorList.none,
        ),
        child: Row(
          children: [
            Container(
              width: 250,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "CHAT",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 0, 8, 0),
                          child: IconButton(
                            onPressed: () {
                              buildAddChatDialog(context);
                            },
                            icon: const Icon(
                              Icons.add_box_outlined,
                              size: 30,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ChatRoomListInterface(),
                ],
              ),
            ),
            Expanded(
              child: GetX<ChatController>(
                  builder: (ChatController chatController) {
                if (chatController.selected.value != "") {
                  return Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Obx(() => Text(
                                chatController.selectedChatRoom.value.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.lime,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ),
                      ChatPageV3(),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildAddChatDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierColor: Colors.white.withOpacity(0),
        builder: (BuildContext context) {
          return AlertDialog(
            content: const SizedBox(
              width: 500,
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add ChatRoom",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  color: Colors.redAccent,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.create,
                  color: Colors.blueAccent,
                ),
              ),
            ],
            actionsOverflowAlignment: OverflowBarAlignment.center,
            actionsOverflowDirection: VerticalDirection.down,
            insetPadding: EdgeInsets.fromLTRB(0, 80, 0, 80),
            backgroundColor: Colors.black45,
          );
        });
  }
}

class ChatRoomListInterface extends StatelessWidget {
  const ChatRoomListInterface({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: chatController.chatRoomList.length,
          shrinkWrap: true,
          physics: const PageScrollPhysics(),
          itemBuilder: (context, index) {
            ChatRoom chatRoom = chatController.chatRoomList[index];
            return Container(
              width: 100,
              height: 60,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(chatRoom.backgroundColor),
                  overlayColor: MaterialStateProperty.all(Colors.white10),
                  alignment: Alignment.centerLeft,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                onPressed: () {
                  chatController.selectChatRoom(chatRoom.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatRoom.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      if (chatController.notiMessages
                              .containsKey(chatRoom.id) &&
                          chatController
                              .notiMessages[chatRoom.id]!.isNotEmpty) {
                        return Container(
                          width: 15,
                          height: 15,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              chatController.notiMessages[chatRoom.id]!.length
                                  .toString(),
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChatInterface extends StatelessWidget {
  const ChatInterface({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
