import 'package:chat_app/app/controller/base_controller.dart';
import 'package:chat_app/app/controller/chat_controller.dart';
import 'package:chat_app/app/controller/member_controller.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/member/model/member.dart';
import 'package:chat_app/app/ui/chat/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../util/time/time_util.dart';

class ChatPageV3 extends StatelessWidget {
  const ChatPageV3({super.key});

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());
    var memberController = Get.put(MemberController());
    var userController = Get.put(BaseController());

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: chatController.scrollController,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: chatController.chatMessages.length,
                  itemBuilder: (context, index) {
                    return buildChatMessages(chatController, index,
                        userController, memberController);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white10,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 70,
                          minHeight: 70,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            controller: chatController.messagePayloadController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            maxLines: 20,
                            expands: false,
                            focusNode: buildInputFocusNode(chatController),
                            onFieldSubmitted: (value) {
                              chatController.sendMessage();
                            },
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    chatController.sendFile();
                                  },
                                  icon: const Icon(
                                    Icons.file_present_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.emoji_emotions_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              chatController.sendMessage();
                            },
                            icon: const Icon(
                              Icons.send,
                              size: 20,
                              color: Colors.limeAccent,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildChatMessages(ChatController chatController, int index,
      BaseController userController, MemberController memberController) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (chatController.goBottom.isTrue) {
        chatController.goUnder();
        if (index + 1 == chatController.chatMessages.length) {
          chatController.goBottom.value = false;
        }
      }
    });

    ChatMessage chatMessage = chatController.chatMessages[index];

    bool isUser = false;

    var userId = userController.user.value.id;
    int memberId = chatMessage.memberId;

    if (userId == memberId) isUser = true;

    Member member = isUser ? Member() : memberController.memberMap[memberId]!;

    if (index != 0 &&
        TimeUtil.dateFormatYYYYMMDD(
                chatController.chatMessages[index - 1].createdAt) ==
            TimeUtil.dateFormatYYYYMMDD(chatMessage.createdAt)) {
      return buildChatBubble(chatMessage, member, isUser);
    } else {
      return Column(
        children: [
          buildChatDateDivider(chatMessage),
          buildChatBubble(chatMessage, member, isUser),
        ],
      );
    }
  }

  Stack buildChatDateDivider(ChatMessage chatMessage) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: 25,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.limeAccent,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              TimeUtil.dateFormatYYYYMMDD(chatMessage.createdAt),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  FocusNode buildInputFocusNode(ChatController chatController) {
    return FocusNode(
      onKeyEvent: (node, event) {
        var enterPressed = event is KeyDownEvent &&
            event.physicalKey == PhysicalKeyboardKey.enter;
        var shiftPressed = HardwareKeyboard.instance.physicalKeysPressed
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
    );
  }

  buildChatBubble(ChatMessage chatMessage, Member member, bool isUser) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChatBubble(
        isUser: isUser,
        message: chatMessage,
        member: member,
        bubbleDecoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(10),
        ),
        messagePayloadTextStyle: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
        messageMemberNameTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        messageCreatedAtTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        messagePayloadPadding: const EdgeInsets.all(3),
        messageMemberNamePadding: const EdgeInsets.all(3),
        messageCreatedAtPadding: const EdgeInsets.all(3),
      ),
    );
  }
}
