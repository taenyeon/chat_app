import 'package:chat_app/app/ui/Login/login_page.dart';
import 'package:chat_app/app/ui/chat/chat_page.dart';
import 'package:chat_app/app/ui/main/main_page.dart';
import 'package:chat_app/app/ui/main/base_page.dart';
import 'package:get/get.dart';

class Route {
  static const initial = '/';
  static const chat = '/chat';
  static const login = '/login';
}

class AppPages {
  static final routes = [
    GetPage(
      name: Route.initial,
      page: () => const BasePage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Route.login,
      page: () => const LoginPage(),
    ),
  ];
}
