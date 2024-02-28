import 'package:intl/intl.dart';

class TimeUtil {
  static String dateFormat(int millis) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat("yyyy/MM/dd hh:mm").format(dateTime);
  }
}
