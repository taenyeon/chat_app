import 'package:chat_app/app/controller/UserController.dart';
import 'package:chat_app/app/route/Route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GetX<UserController>(
          initState: (state) {
            Get.find<UserController>().user;
          },
          builder: (UserController _) {
            return _.user.isBlank
                ? Center(
                    child: Column(
                      children: const <Widget>[TextField(), TextField()],
                    ),
                  )
                : Center(
                    child: Column(
                      children: const <Widget>[Text('이미 로그인 함.')],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
