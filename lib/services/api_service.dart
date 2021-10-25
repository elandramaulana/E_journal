import 'package:dio/dio.dart';

class ApiService {
  final _dio = Dio(BaseOptions(
    baseUrl: "https://journal-api-project.herokuapp.com/api/v1/",
    connectTimeout: 15000,
    receiveTimeout: 15000,
    validateStatus: (status) {
      return status != null && status > 0;
    },
    headers: {"app-id": "615ffee43a908688ce8b90de"},
  ));

  postRequest(String path, dynamic data) async {
    _dio.interceptors.add(LogInterceptor(
        responseHeader: true, responseBody: true, requestBody: true));
    return await _dio.post(path, data: data);
  }

  getRequest(String path, dynamic data) async {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
    ));
    return await _dio.post(path, queryParameters: data);
  }
}
