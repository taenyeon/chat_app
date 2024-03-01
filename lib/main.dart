import 'package:chat_app/app/util/chat/chat_client.dart';
import 'package:chat_app/app/util/log/logging_util.dart';
import 'package:chat_app/app/util/time/time_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/app/route/route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  settingLogger();
  await settingDesktopMinSize();
  ChatClient.init();
  runApp(const MyApp());
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
  await windowManager.ensureInitialized();

  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
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
        appBarTheme: const AppBarTheme(
          color: Colors.limeAccent,
        ),
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.limeAccent,
              background: const Color(0xff1c1c1c).withOpacity(0.1),
            ),
        primarySwatch: Colors.lime,
        primaryColor: Colors.limeAccent,
        textTheme: TextTheme(
          headlineSmall: GoogleFonts.exo2(
              color: Colors.limeAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      getPages: AppPages.routes,
    );
  }
}
