import 'package:chat_app/app/util/chat/chat_client.dart';
import 'package:chat_app/app/util/log/logging_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/app/route/route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

void main() async {
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
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ChatClient.init();
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
              background: Colors.black,
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
