import 'package:chat_app/app/ui/Login/LoginPage.dart';
import 'package:get/get.dart';

abstract class Route{
  static const initial = '/';
  static const login = '/login';
}

class AppPages{
  static final routes = [
    GetPage(name: Route.initial, page: () => LoginPage())
  ];
}