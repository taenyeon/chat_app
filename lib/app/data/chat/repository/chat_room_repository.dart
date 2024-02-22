import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/chat/model/chat_room.dart';
import 'package:chat_app/app/data/chat/provider/chat_room_api.dart';

class ChatRoomRepository {
  final ChatRoomApi chatRoomApi = ChatRoomApi();

  Future<List<ChatRoom>> loadMyChatRoom() async {
    // return await chatRoomApi.selectMyChatRoomList();
    return chatRoomApi.selectMyChatRoomListTest();
  }

  Future<List<ChatMessage>> selectChatMessageList(String roomId) async {
    return await chatRoomApi.selectChatMessageListTest(roomId);
  }
}
