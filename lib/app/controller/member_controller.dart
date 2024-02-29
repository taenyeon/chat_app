import 'package:chat_app/app/data/member/repository/member_repository.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../data/member/model/member.dart';

class MemberController extends GetxController {
  late Logger log;
  late MemberRepository memberRepository;

  RxList<Member> memberList = <Member>[].obs;

  @override
  void onInit() async {
    log = Logger("MemberController");
    memberRepository = MemberRepository();

    var list = await memberRepository.getMemberList();
    memberList = list.obs;
    super.onInit();
  }
}
