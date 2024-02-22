import 'package:chat_app/app/controller/base_controller.dart';
import 'package:chat_app/app/controller/chat_controller.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/chat/model/chat_room.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatRoomController = Get.put(ChatController());
    BaseController baseController = Get.put(BaseController());
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
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
                      IconButton(
                        padding: const EdgeInsets.fromLTRB(170, 0, 8, 0),
                        onPressed: () {
                          buildAddChatDialog(context);
                        },
                        icon: const Icon(
                          Icons.add_box_outlined,
                          size: 30,
                          color: Colors.white60,
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white10,
                ),
                child: Column(
                  children: [
                    buildCurrentChatRoomName(),
                    Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Obx(
                              () => ListView.builder(
                                  itemCount:
                                      chatRoomController.chatMessages.length,
                                  shrinkWrap: true,
                                  physics: const PageScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    ChatMessage chatMessage =
                                        chatRoomController.chatMessages[index];
                                    return buildMessage(
                                        chatMessage, baseController);
                                  }),
                            ),
                          ),
                          MessageBar(
                            messageBarColor: Colors.white10,
                            sendButtonColor: Colors.limeAccent,
                            onSend: (_) {},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding buildCurrentChatRoomName() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      // child: GetX<ChatController>(builder: (ChatController controller) {
      //   return Text(
      //     controller.selectedChatRoom.value.name,
      //     style: const TextStyle(
      //       color: Colors.white,
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   );
      // }),
    );
  }

  BubbleNormal buildMessage(
      ChatMessage chatMessage, BaseController baseController) {
    if (chatMessage.memberId == baseController.user.value.id) {
      return BubbleNormal(
        text: chatMessage.payload,
        isSender: true,
      );
    } else {
      return BubbleNormal(
        text: chatMessage.payload,
        isSender: false,
      );
    }
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
    ChatController chatRoomController = Get.put(ChatController());
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: chatRoomController.chatRoomList.length,
          shrinkWrap: true,
          physics: const PageScrollPhysics(),
          itemBuilder: (context, index) {
            ChatRoom chatRoom = chatRoomController.chatRoomList[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
              child: Container(
                width: 100,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(chatRoom.backgroundColor),
                      overlayColor: MaterialStateProperty.all(Colors.white10),
                      alignment: Alignment.centerLeft,
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      chatRoomController.select(chatRoom.id);
                    },
                    child: Column(
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
                          "by",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
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
