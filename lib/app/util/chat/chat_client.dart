import 'dart:convert';

import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/token/repository/token_repository.dart';
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
    log.info("[INIT] accessToken : $accessToken");
    if (accessToken != null && client == null) {
      client = stompClient(accessToken);
      //client?.activate();
      client?.activate();
    }
  }

  static StompClient stompClient(accessToken) {
    return StompClient(
      config: StompConfig.sockJS(
        url: 'http://localhost:8000/chat',
        stompConnectHeaders: {
          "access_token": accessToken,
        },
        // beforeConnect: beforeConnect,
        onConnect: connect,
        onDisconnect: disconnect,
      ),
    );
  }

  static disconnect(StompFrame frame) {
    log.info("[DISCONNECT] USER : ${frame.headers['user-name']}");
  }

  static Future<void> beforeConnect() async {
    log.info("[TRY CONNECT] waiting to connect...");
    await Future.delayed(const Duration(milliseconds: 200));
  }

  static void connect(StompFrame frame) {
    log.info("[CONNECT] USER : ${frame.headers['user-name']}");
    subscribe(frame);
  }

  static subscribe(StompFrame frame) {
    log.info("[SUBSCRIBE] URL : /sub/chat/${frame.headers['user-name']}");
    client?.subscribe(
      destination: "/sub/chat/${frame.headers['user-name']}",
      callback: (res) => {
        Get.snackbar("RECEIVE MESSAGE", res.body!),
      },
    );
  }

  static send(ChatMessage message) async {
    client?.send(
      destination: "/pub/chat/message",
      headers: {"access_token": await tokenRepository.getAccessToken()},
      body: jsonEncode(message.toJson()),
    );
  }
}
