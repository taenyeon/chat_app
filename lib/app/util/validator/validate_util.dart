import 'dart:ffi';

class ValidateUtil {
  static String? getUrl(String raw) {
    return RegExp(r'(?:(?:https?|ftp)://)+[\w/\-?=%.]+\.[\w/\-?=%.]+')
        .stringMatch(raw);
  }

  static bool isImage(String raw) {
    return RegExp(r'(?:(?:http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png|jpng))')
        .hasMatch(raw);
  }
}
