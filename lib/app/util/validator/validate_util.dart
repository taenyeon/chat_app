import 'dart:ffi';

class ValidateUtil {
  static String? getUrl(String raw) {
    return RegExp(r'(?:(?:https?|ftp)://)+[\w/\-?=%.]+\.[\w/\-?=%.]+')
        .stringMatch(raw);
  }

  static bool isImage(String raw) {
    return RegExp(r'\.(jpg|jpeg|png|gif|bmp|webp)$', caseSensitive: false)
        .hasMatch(raw);
  }
}
