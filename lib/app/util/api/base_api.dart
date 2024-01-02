import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Dio> baseApi() async {
  var api = Dio();
  const storage = FlutterSecureStorage();

  // options
  api.options.baseUrl = 'http://localhost:8080/api';
  // interceptors
  api.interceptors.clear();
  api.interceptors.add(InterceptorsWrapper(
    onRequest: (option, handler) async {
      var accessToken = await storage.read(key: 'ACCESS_TOKEN');
      option.headers['access_token'] = accessToken;
      return handler.next(option);
    },
    onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        return await retry(storage, error, api, handler);
      } else {
        return handler.next(error);
      }
    },
  ));
  return api;
}

retry(FlutterSecureStorage storage, DioException error, Dio api,
    ErrorInterceptorHandler handler) async {
  var refreshToken = await storage.read(key: 'REFRESH_TOKEN');
  var accessToken = await storage.read(key: 'ACCESS_TOKEN');
  var refreshApi = Dio();
  refreshApi.interceptors.clear();
  refreshApi.interceptors
      .add(InterceptorsWrapper(onError: (error, handler) async {
    if (error.response?.statusCode == 401) {
      await storage.delete(key: 'ACCESS_TOKEN');
      await storage.delete(key: 'REFRESH_TOKEN');
      // 로그인으로 이동
      return handler.next(error);
    }
  }));
  var response = await refreshApi.post('/user/accessToken', data: {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  });
  await storage.write(
    key: 'ACCESS_TOKEN',
    value: response.data.accessToken,
  );
  error.requestOptions.headers['accessToken'] = response.data.accessToken;
  var clonedRequest = await api.request(error.requestOptions.path,
      options: Options(
        method: error.requestOptions.method,
        headers: error.requestOptions.headers,
      ),
      data: error.requestOptions.data,
      queryParameters: error.requestOptions.queryParameters);
  return handler.resolve(clonedRequest);
}
