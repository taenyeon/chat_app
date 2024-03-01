import 'package:chat_app/app/controller/base_controller.dart';
import 'package:chat_app/app/controller/chat_controller.dart';
import 'package:chat_app/app/controller/member_controller.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/member/model/member.dart';
import 'package:chat_app/app/ui/chat/chat_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChatPageV3 extends StatelessWidget {
  const ChatPageV3({super.key});

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());
    var memberController = Get.put(MemberController());
    var userController = Get.put(BaseController());
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatController.chatMessages.length,
              itemBuilder: (context, index) {
                ChatMessage chatMessage = chatController.chatMessages[index];

                bool isUser = false;

                var userId = userController.user.value.id;
                int memberId = chatMessage.memberId;

                Member member = memberController.memberMap[memberId]!;

                if (userId == memberId) isUser = true;

                return buildChatBubble(chatMessage, member, isUser);
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: Colors.white10,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 100,
                    ),
                    child: TextFormField(
                      controller: chatController.messagePayloadController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      expands: false,
                      focusNode: FocusNode(
                        onKeyEvent: (node, event) {
                          var enterPressed = event is KeyDownEvent &&
                              event.physicalKey == PhysicalKeyboardKey.enter;
                          var shiftPressed = HardwareKeyboard
                              .instance.physicalKeysPressed
                              .any((element) => <PhysicalKeyboardKey>{
                                    PhysicalKeyboardKey.shiftLeft,
                                    PhysicalKeyboardKey.shiftRight,
                                  }.contains(element));

                          if (enterPressed) {
                            if (shiftPressed) {
                              chatController.addTextNewLine();
                              return KeyEventResult.handled;
                            }
                            chatController.sendMessage();
                            return KeyEventResult.handled;
                          }
                          return KeyEventResult.ignored;
                        },
                      ),
                      onFieldSubmitted: (value) {
                        chatController.sendMessage();
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: Colors.limeAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Obx buildChatBubble(ChatMessage chatMessage, Member member, bool isUser) {
    return Obx(() {
      return ChatBubble(
        message: chatMessage,
        member: member,
        messagePayloadTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        bubbleDecoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(10),
        ),
        bubbleHeight: 100,
        bubbleWidth: 100,
        isUser: isUser,
        messageMemberNameTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        messageCreatedAtTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        messagePayloadPadding: const EdgeInsets.all(3),
        messageMemberNamePadding: const EdgeInsets.all(3),
        messageCreatedAtPadding: const EdgeInsets.all(3),
      );
    });
  }
}
