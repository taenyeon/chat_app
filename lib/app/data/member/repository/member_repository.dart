import 'package:chat_app/app/data/member/model/member.dart';

import '../provider/member_api.dart';

class MemberRepository {
  final MemberApi memberApi = MemberApi();

  Future<List<Member>> getMemberList() async => await memberApi.getMemberList();
}
