import 'dart:io';

import 'package:dio/dio.dart';

class ServiceRegister {
  regisUser(String username, String password, String email, int role,
      String name, String passwordConfirmation) async {
    var dioregister = Dio();
    dioregister.options
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

    dioregister.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (options, handler) {
          // return handler.resolve( Response(data:"xxx"));
          // return handler.reject( DioError(message: "eh"));
          return handler.next(options);
        },
      ))
      ..add(LogInterceptor(responseBody: false)); //Open log;

    var response = await dioregister.post(
      'user',
      data: {"username": username, "password": password, "email": email},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print(response.data);
  }
}
