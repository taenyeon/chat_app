class ValidateUtil {
  static String? getUrl(String raw) {
    return RegExp(r'(?:(?:https?|ftp)://)+[\w/\-?=%.]+\.[\w/\-?=%.]+')
        .stringMatch(raw);
  }
}
