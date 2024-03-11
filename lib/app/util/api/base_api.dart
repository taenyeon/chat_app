import 'package:chat_app/app/data/token/repository/token_repository.dart';
import 'package:chat_app/app/data/user/repository/user_repository.dart';
import 'package:chat_app/app/util/log/logging_util.dart';
import 'package:chat_app/app/util/response/response.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

Future<Dio> baseApi() async {
  var api = Dio();
  TokenRepository tokenRepository = TokenRepository();
  UserRepository userRepository = UserRepository();
  Logger log = LoggingUtil.logger("🚀API");

  // options
  api.options.baseUrl = 'http://127.0.0.1:8001/api';
  // interceptors
  api.interceptors.clear();
  api.interceptors.add(
    InterceptorsWrapper(
      onRequest: (option, handler) async {
        // ACCESS_TOKEN SETTING
        var accessToken = await tokenRepository.getAccessToken();
        if (accessToken != null) {
          option.headers['access_token'] = accessToken;
        }
        String? prettyJson = "";
        try {
          prettyJson = LoggingUtil.getPrettyJson(option.data);
        } catch (e) {
          prettyJson = "FILE";
        }

        // REQUEST LOG
        log.info("\n[\x1B[34mREQUEST\x1B[0m]\n\n"
            "method : ${option.method}\n"
            "url : ${option.uri}\n\n"
            "headers : \n${LoggingUtil.getPrettyString(option.headers)}\n"
            "data : $prettyJson\n"
            "queryParams : ${option.queryParameters}\n\n"
            "extra : ${option.extra}\n\n");
        // RETURN
        return handler.next(option);
      },
      onError: (error, handler) async {
        var accessToken = await tokenRepository.getAccessToken();
        var statusCode = error.response?.statusCode;
        log.info(
            "[DIO ERROR] - statusCode : $statusCode, message : ${error.message}");
        if ((statusCode == 401 || statusCode == 403) && accessToken != null) {
          log.info("[DIO RETRY] - statusCode : $statusCode");
          return await retry(
              tokenRepository, userRepository, error, api, handler);
        } else {
          return handler.next(error);
        }
      },
      // RESPONSE
      onResponse: (response, handler) {
        // RESPONSE LOG
        log.info("\n[\x1B[31mRESPONSE\x1B[0m]\n\n"
            "url : ${response.realUri}\n\n"
            "headers :\n${response.headers}\n"
            "body : ${LoggingUtil.getPrettyJson(response.data)}\n\n");
        // RETURN
        return handler.resolve(response);
      },
    ),
  );
  return api;
}

retry(TokenRepository tokenRepository, UserRepository userRepository,
    DioException error, Dio api, ErrorInterceptorHandler handler) async {
  Logger log = LoggingUtil.logger("🚀API RETRY");

  var dio = Dio();

  var refreshToken = await tokenRepository.getRefreshToken();
  var accessToken = await tokenRepository.getAccessToken();

  dio.options.baseUrl = 'http://127.0.0.1:8001/api';
  dio.interceptors.clear();

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) async {
        log.info("errror!!!");
        var statusCode = error.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          await tokenRepository.dropTokens();
          // 로그인으로 이동
          Get.offAllNamed("/login");
          return handler.next(error);
        }
      },
      onRequest: (option, handler) {
        log.info("\n[\x1B[34mREQUEST\x1B[0m]\n\n"
            "method : ${option.method}\n"
            "url : ${option.uri}\n\n"
            "headers : \n${LoggingUtil.getPrettyString(option.headers)}\n"
            "data : ${LoggingUtil.getPrettyJson(option.data)}\n"
            "queryParams : ${option.queryParameters}\n\n"
            "extra : ${option.extra}\n\n");
        return handler.next(option);
      },
      onResponse: (response, handler) {
        log.info("\n[\x1B[31mRESPONSE\x1B[0m]\n\n"
            "url : ${response.realUri}\n\n"
            "headers :\n${response.headers}\n"
            "body : ${LoggingUtil.getPrettyJson(response.data)}\n\n");
        return handler.resolve(response);
      },
    ),
  );

  var response = await dio.post('/user/accessToken', data: {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  });
  var newToken = response.data['body']['accessToken'];

  if (newToken != null) {
    await tokenRepository.saveAccessToken(newToken);
    var clonedRequest = await api.request(error.requestOptions.path,
        options: Options(
          method: error.requestOptions.method,
          headers: error.requestOptions.headers,
        ),
        data: error.requestOptions.data,
        queryParameters: error.requestOptions.queryParameters);
    return handler.resolve(clonedRequest);
  }

  return handler.next(error);
}
