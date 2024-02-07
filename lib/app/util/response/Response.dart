class ResponseData {
  late String resultCode;
  late String resultMessage;
  late Map<String, dynamic> body;

  ResponseData({resultCode, resultMessage, body});

  ResponseData.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMessage = json['resultMessage'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json['resultCode'] = resultCode;
    json['resultMessage'] = resultMessage;
    json['body'] = body;
    return json;
  }
}
