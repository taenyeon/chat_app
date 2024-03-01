import 'package:chat_app/app/data/member/repository/member_repository.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../data/member/model/member.dart';

class MemberController extends GetxController {
  late Logger log;
  late MemberRepository memberRepository;

  RxMap<int, Member> memberMap = <int, Member>{}.obs;

  @override
  void onInit() async {
    log = Logger("MemberController");
    memberRepository = MemberRepository();

    var list = await memberRepository.getMemberList();
    var map = {for (var member in list) member.id: member};
    memberMap.value = map;
    super.onInit();
  }
}
