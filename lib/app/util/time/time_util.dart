import 'package:intl/intl.dart';

class TimeUtil {
  static String dateFormat(int millis) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat("y/MM/dd hh:mm").format(dateTime);
  }

  static String dateFormatYYYYMMDD(int millis) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat("y/MM/dd").format(dateTime);
  }

  static String dateFormatHHMM(int millis) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat("hh:mm").format(dateTime);
  }
}
