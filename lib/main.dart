import 'dart:io';

import 'package:chat_app/app/route/route.dart';
import 'package:chat_app/app/util/chat/chat_client.dart';
import 'package:chat_app/app/util/log/logging_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:logging/logging.dart';
import 'package:window_manager/window_manager.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  settingLogger();

  await settingNotify();

  if (!kIsWeb) await settingDesktopMinSize();

  ChatClient.init();

  runApp(const MyApp());
}

Future<void> settingNotify() async {
  if (!kIsWeb) {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      await localNotifier.setup(appName: "chat-app");
    }
  }
}

void settingLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('✈️ ${record.time}'
          ' - '
          '${LoggingUtil.getLogLevel(record.level)} '
          '[SEQ : ${record.sequenceNumber}] '
          '\x1B[34m${record.loggerName}\x1B[0m'
          ' : '
          '${record.message}');
    }
  });
}

Future<void> settingDesktopMinSize() async {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(800, 600));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1c1c1c).withOpacity(0.1),
        appBarTheme: const AppBarTheme(
          color: Colors.limeAccent,
        ),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.limeAccent,
              background: const Color(0xff1c1c1c).withOpacity(0.1),
            ),
        primarySwatch: Colors.lime,
        primaryColor: Colors.limeAccent,
        textTheme: TextTheme(),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1c1c1c).withOpacity(0.1),
        appBarTheme: const AppBarTheme(
          color: Colors.limeAccent,
        ),
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.limeAccent,
              background: const Color(0xff1c1c1c).withOpacity(0.1),
            ),
        primarySwatch: Colors.lime,
        primaryColor: Colors.limeAccent,
        textTheme: TextTheme(),
      ),
      initialRoute: '/',
      getPages: AppPages.routes,
    );
  }
}
