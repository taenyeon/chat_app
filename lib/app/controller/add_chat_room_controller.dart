import 'package:chat_app/app/controller/member_controller.dart';
import 'package:chat_app/app/data/chat/repository/chat_room_repository.dart';
import 'package:chat_app/app/data/member/model/member.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class AddChatRoomController extends GetxController {
  late Logger log;
  late TextEditingController nameController;
  late TextEditingController findMemberByNameController;
  late ChatRoomRepository chatRoomRepository;
  RxList<Member> members = <Member>[].obs;
  RxList<Member> selectedMembers = <Member>[].obs;

  @override
  void onInit() {
    log = Logger("ProfileController");
    var memberController = Get.put(MemberController());
    nameController = TextEditingController();
    findMemberByNameController = TextEditingController();
    chatRoomRepository = ChatRoomRepository();
    members.value = memberController.memberMap.values.toList();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void selectMember(int index) {
    Member member = members[index];
    members.removeAt(index);
    selectedMembers.value = [...selectedMembers, member];
  }

  void unSelectMember(int index) {
    var selectedMember = selectedMembers[index];
    selectedMembers.removeAt(index);
    members.value = [...members, selectedMember];
  }

  void add() {
    String roomName = nameController.text;

    if (roomName == "") return;

    chatRoomRepository.add(roomName, selectedMembers);
  }
}
