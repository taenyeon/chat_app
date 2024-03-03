import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/chat/model/chat_room.dart';
import 'package:chat_app/app/data/chat/provider/chat_message_api.dart';
import 'package:chat_app/app/data/chat/provider/chat_room_api.dart';

class ChatMessageRepository {
  final ChatMessageApi chatMessageApi = ChatMessageApi();

  Future<List<ChatMessage>> getChatMessageByRoomId(String roomId) async =>
      await chatMessageApi.getChatMessageByRoomId(roomId);
}
