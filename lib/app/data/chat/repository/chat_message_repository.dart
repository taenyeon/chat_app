import 'package:chat_app/app/data/chat/model/chat_message.dart';
import 'package:chat_app/app/data/chat/provider/chat_message_api.dart';
import 'package:file_picker/file_picker.dart';

class ChatMessageRepository {
  final ChatMessageApi chatMessageApi = ChatMessageApi();

  Future<List<ChatMessage>> getChatMessageByRoomId(
          String roomId, int page) async =>
      await chatMessageApi.getChatMessageByRoomId(roomId, page);

  sendFile(String roomId, FilePickerResult result) async =>
      await chatMessageApi.sendFile(roomId, result);
}
