import 'package:chat_app/app/data/chat/model/chatRoom.dart';
import 'package:chat_app/app/data/chat/provider/chat_room_api.dart';

class ChatRoomRepository {
  final ChatRoomApi chatRoomApi = ChatRoomApi();

  Future<List<ChatRoom>> loadMyChatRoom() async {
    // return await chatRoomApi.selectMyChatRoomList();
    return chatRoomApi.selectMyChatRoomListTest();
  }
}
