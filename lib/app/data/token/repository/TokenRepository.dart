import 'package:chat_app/app/util/storage/Storage.dart';

class TokenRepository {
  static const ACCESS_TOKEN_KEY = "accessToken";
  static const REFRESH_TOKEN_KEY = "refreshToken";
  var secureStorage = Storage.secureStorage;

  // Default Function
  save(String key, String value) async =>
      await secureStorage.write(key: key, value: value);

  drop(String key) async => await secureStorage.delete(key: key);

  // AccessToken Function
  getAccessToken() async => await secureStorage.read(key: ACCESS_TOKEN_KEY);

  saveAccessToken(String value) async => await save(ACCESS_TOKEN_KEY, value);

  dropAccessToken() async => await drop(ACCESS_TOKEN_KEY);

  // RefreshToken Function
  getRefreshToken() async => await secureStorage.read(key: REFRESH_TOKEN_KEY);

  saveRefreshToken(String value) async => await save(REFRESH_TOKEN_KEY, value);

  dropRefreshToken() async => await drop(REFRESH_TOKEN_KEY);

  // Tokens Function
  saveTokens(String accessToken, String refreshToken) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
  }

  dropTokens() async {
    await dropAccessToken();
    await dropRefreshToken();
  }
}
