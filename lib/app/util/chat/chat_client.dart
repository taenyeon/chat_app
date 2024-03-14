import 'dart:convert';

import 'package:chat_app/app/controller/chat_controller.dart';
import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/token/repository/token_repository.dart';
import 'package:chat_app/app/util/notify/push_util.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatClient {
  static StompClient? client;
  static Logger log = Logger("ChatClient");
  static TokenRepository tokenRepository = TokenRepository();

  static init() async {
    var accessToken = await tokenRepository.getAccessToken();
    if (accessToken != null && client == null) {
      client = await stompClient();
      client?.activate();
    } else {
      while (client == null) {
        await Future.delayed(const Duration(milliseconds: 1000));

        var accessToken = await tokenRepository.getAccessToken();

        if (accessToken != null) {
          client = await stompClient();
          client?.activate();
        }
      }
    }
  }

  static Future<StompClient> stompClient() async {
    await Future.delayed(const Duration(milliseconds: 200));

    return StompClient(
      config: StompConfig.sockJS(
        url: 'http://localhost:8000/chat',
        stompConnectHeaders: {
          "access_token": await tokenRepository.getAccessToken(),
        },
        beforeConnect: beforeConnect,
        onConnect: connect,
        onDisconnect: disconnect,
        onStompError: onError,
      ),
    );
  }

  static disconnect(StompFrame frame) {
    log.info("[DISCONNECT] USER : ${frame.headers['user-name']}");
  }

  static Future<void> beforeConnect() async {}

  static void connect(StompFrame frame) {
    log.info("[CONNECT] USER : ${frame.headers['user-name']}");
    subscribe(frame);
  }

  static onError(StompFrame frame) {
    log.info("[ERROR] ${frame.headers}");
  }

  static subscribe(StompFrame frame) {
    var chatController = Get.put(ChatController());
    log.info("[SUBSCRIBE] URL : /sub/chat/${frame.headers['user-name']}");
    client!.subscribe(
        destination: "/sub/chat/${frame.headers['user-name']}",
        callback: (res) {
          if (res.body != null) {
            var json = jsonDecode(res.body!);
            ChatMessage chatMessage = ChatMessage.fromJson(json);
            if (chatController.selectedChatRoom.value.id ==
                chatMessage.roomId) {
              chatController.addMessage(chatMessage);
            } else {
              chatController.addNotiMessage(chatMessage);
              PushUtil.sendLocalPush(chatMessage);
            }
          }
        });
  }

  static send(ChatMessage message) async {
    client!.send(
      destination: "/pub/chat/message",
      headers: {"access_token": await tokenRepository.getAccessToken()},
      body: jsonEncode(message.toJson()),
    );
  }
}
