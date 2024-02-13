import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Expanded(child: ChatRoomListInterface())],
    );
  }
}

class ChatRoomListInterface extends StatelessWidget {
  const ChatRoomListInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListBody(
          children: _chatList(),
        ),
      ),
    );
  }

  List<Widget> _chatList() {
    return [];
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
