import 'package:intl/intl.dart';

class TimeUtil {
  static String dateFormat(int millis) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat("y/MM/dd HH:mm").format(dateTime);
  }

  static String dateFormatYYYYMMDD(int millis) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat("y/MM/dd").format(dateTime);
  }

  static String dateFormatHHMM(int millis) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat("HH:mm").format(dateTime);
  }
}
