class Token {
  late String accessToken;
  late String refreshToken;

  Token({accessToken, refreshToken});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  toJson() => <String, dynamic>{
        "accessToken": accessToken,
        'refreshToken': refreshToken,
      };
}
