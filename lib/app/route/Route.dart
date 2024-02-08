import 'package:chat_app/app/ui/Login/LoginPage.dart';
import 'package:chat_app/app/ui/main/MainPage.dart';
import 'package:get/get.dart';

abstract class Route {
  static const initial = '/';
  static const login = '/login';
}

class AppPages {
  static final routes = [
    GetPage(
      name: Route.initial,
      page: () => MainPage(),
    ),
    GetPage(
      name: "/login",
      page: () => LoginPage(),
    )
  ];
}
