import 'dart:convert';

import 'package:logging/logging.dart';

class LoggingUtil {
  static Logger logger(String title) {
    return Logger(title);
  }

  static String getLogLevel(Level level) {
    if (level == Level.INFO) {
      return '\x1B[32mINFO\x1B[0m';
    } else if (level == Level.WARNING) {
      return '\x1B[33mWARNING\x1B[0m';
    } else {
      return '\x1B[31mERROR\x1B[0m';
    }
  }

  static String? getPrettyJson(Map<String, dynamic>? object) {
    if (object != null && object.isNotEmpty) {
      const jsonEncoder = JsonEncoder.withIndent('  ');
      return jsonEncoder.convert(object);
    }
    return null;
  }

  static String getPrettyString(Map<String, dynamic> object) {
    final stringBuffer = StringBuffer();
    object.forEach((key, value) {
      stringBuffer.writeln('$key: $value');
    });
    return stringBuffer.toString();
  }
}
