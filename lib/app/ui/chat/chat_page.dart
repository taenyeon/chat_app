import 'package:chat_app/app/controller/chat_controller.dart';
import 'package:chat_app/app/data/chat/model/chatRoom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white10,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Chat",
                          style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatRoomListInterface extends StatelessWidget {
  const ChatRoomListInterface({super.key});

  @override
  Widget build(BuildContext context) {
    ChatRoomController chatRoomController = Get.put(ChatRoomController());
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: chatRoomController.chatRoomList.length,
          shrinkWrap: true,
          physics: const PageScrollPhysics(),
          itemBuilder: (context, index) {
            ChatRoom chatRoom = chatRoomController.chatRoomList[index];
            return Padding(
              padding: const EdgeInsets.all(4.5),
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white10,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
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
                        "오늘 뭐행",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ],
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
