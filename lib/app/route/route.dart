import 'package:chat_app/app/ui/Login/login_page.dart';
import 'package:chat_app/app/ui/main/main_page.dart';
import 'package:chat_app/app/ui/main/main_test_page.dart';
import 'package:get/get.dart';

abstract class Route {
  static const initial = '/';
  static const login = '/login';
}

class AppPages {
  static final routes = [
    GetPage(
      name: Route.initial,
      page: () => const MainPage(),
    ),
    GetPage(
      name: "/login",
      page: () => const LoginPage(),
    ),
    GetPage(
      name: "/mainTest",
      page: () => const MainTestPage(),
    ),
  ];
}
