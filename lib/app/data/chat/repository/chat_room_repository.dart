import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/chat/model/chat_room.dart';
import 'package:chat_app/app/data/chat/provider/chat_room_api.dart';

class ChatRoomRepository {
  final ChatRoomApi chatRoomApi = ChatRoomApi();

  Future<List<ChatRoom>> getMyChatRoomList() async =>
      await chatRoomApi.getMyChatRoomList();
}
