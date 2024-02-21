import 'package:chat_app/app/data/chat/repository/chat_room_repository.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class ChatRoomController extends GetxController {
  late Logger log;
  late ChatRoomRepository chatRoomRepository;
  RxList chatRoomList = [].obs;

  @override
  Future<void> onInit() async {
    log = Logger("chatRoomController");
    chatRoomRepository = ChatRoomRepository();
    await loadMyChatRoom();
    super.onInit();
  }

  loadMyChatRoom() async {
    chatRoomList.value = await chatRoomRepository.loadMyChatRoom();
  }
}
