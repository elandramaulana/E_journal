import 'dart:io';

import 'package:dio/dio.dart';

class ServiceLogin {
  loginUser(String username, String password) async {
    var dio = Dio();
    dio.options
      ..baseUrl = 'https://journal-api-project.herokuapp.com/api/v1/'
      ..connectTimeout = 11000 //11s
      ..receiveTimeout = 11000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        'common-header': 'xx',
      };

    dio.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (options, handler) {
          // return handler.resolve( Response(data:"xxx"));
          // return handler.reject( DioError(message: "eh"));
          return handler.next(options);
        },
      ))
      ..add(LogInterceptor(responseBody: false)); //Open log;

    var response = await dio.post(
      'authenticate',
      data: {"username": username, "password": password},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print(response.data);
  }
}
