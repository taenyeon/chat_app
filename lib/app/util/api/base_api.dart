import 'dart:convert';

import 'package:chat_app/app/data/token/repository/TokenRepository.dart';
import 'package:chat_app/app/data/user/repository/UserRepository.dart';
import 'package:chat_app/app/util/log/LoggingUtil.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

Future<Dio> baseApi() async {
  var api = Dio();
  TokenRepository tokenRepository = TokenRepository();
  UserRepository userRepository = UserRepository();
  Logger log = LoggingUtil.logger("🚀API");

  // options
  api.options.baseUrl = 'http://localhost:8080/api';
  // interceptors
  api.interceptors.clear();
  api.interceptors.add(InterceptorsWrapper(onRequest: (option, handler) async {
    var accessToken = await tokenRepository.getAccessToken();
    option.headers['access_token'] = accessToken;
    log.info("\n[\x1B[34mREQUEST\x1B[0m]\n\n"
        "method : ${option.method}\n"
        "url : ${option.uri}\n\n"
        "headers : \n${LoggingUtil.getPrettyString(option.headers)}\n"
        "queryParams : ${option.queryParameters}\n\n"
        "extra : ${option.extra}\n\n");
    return handler.next(option);
  }, onError: (error, handler) async {
    var statusCode = error.response?.statusCode;
    if (statusCode == 401 || statusCode == 403) {
      return await retry(tokenRepository, userRepository, error, api, handler);
    } else {
      return handler.next(error);
    }
  }, onResponse: (response, handler) {
    log.info("\n[\x1B[31mRESPONSE\x1B[0m]\n\n"
        "url : ${response.realUri}\n\n"
        "headers :\n${response.headers}\n"
        "body : ${LoggingUtil.getPrettyJson(response.data)}\n\n");
    return handler.resolve(response);
  }));
  return api;
}

retry(TokenRepository tokenRepository, UserRepository userRepository,
    DioException error, Dio api, ErrorInterceptorHandler handler) async {
  var refreshToken = await tokenRepository.getRefreshToken();
  var accessToken = await tokenRepository.getAccessToken();

  var refreshApi = Dio();

  refreshApi.interceptors.clear();

  refreshApi.interceptors
      .add(InterceptorsWrapper(onError: (error, handler) async {
    var statusCode = error.response?.statusCode;
    if (statusCode == 401 || statusCode == 403) {
      await tokenRepository.dropTokens();
      // 로그인으로 이동
      return handler.next(error);
    }
  }));
  var response = await refreshApi.post('/user/accessToken', data: {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  });
  tokenRepository.saveAccessToken(response.data.body.accessToken);
  error.requestOptions.headers['accessToken'] = response.data.body.accessToken;
  var clonedRequest = await api.request(error.requestOptions.path,
      options: Options(
        method: error.requestOptions.method,
        headers: error.requestOptions.headers,
      ),
      data: error.requestOptions.data,
      queryParameters: error.requestOptions.queryParameters);
  return handler.resolve(clonedRequest);
}
