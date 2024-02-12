import 'package:chat_app/app/util/storage/storage.dart';
import 'package:logging/logging.dart';

class TokenRepository {
  Logger log = Logger("TokenRepository");
  static const accessTokenKey = "accessToken";
  static const refreshTokenkey = "refreshToken";
  var secureStorage = Storage.secureStorage;

  // Default Function
  save(String key, String value) async =>
      await secureStorage.write(key: key, value: value);

  drop(String key) async => await secureStorage.delete(key: key);

  // AccessToken Function
  getAccessToken() async => await secureStorage.read(key: accessTokenKey);

  saveAccessToken(String value) async => await save(accessTokenKey, value);

  dropAccessToken() async => await drop(accessTokenKey);

  // RefreshToken Function
  getRefreshToken() async => await secureStorage.read(key: refreshTokenkey);

  saveRefreshToken(String value) async => await save(refreshTokenkey, value);

  dropRefreshToken() async => await drop(refreshTokenkey);

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
