// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:e_journal/models/user.dart';

// class ServiceRegister {
//   regisUser(String username, String password, String email, int role,
//       String name, String passwordConfirmation) async {
//     var dioregister = Dio();
//     dioregister.options
//       ..baseUrl = 'https://journal-api-project.herokuapp.com/api/v1/'
//       ..connectTimeout = 11000 //11s
//       ..receiveTimeout = 11000
//       ..validateStatus = (int? status) {
//         return status != null && status > 0;
//       }
//       ..headers = {
//         HttpHeaders.userAgentHeader: 'dio',
//         'common-header': 'xx',
//       };

//     dioregister.interceptors
//       ..add(InterceptorsWrapper(
//         onRequest: (options, handler) {
//           // return handler.resolve( Response(data:"xxx"));
//           // return handler.reject( DioError(message: "eh"));
//           return handler.next(options);
//         },
//       ))
//       ..add(LogInterceptor(
//           responseBody: false,
//           responseHeader: true,
//           requestBody: true)); //Open log;

//     Future<User> createUser(
//       String username,
//       String password,
//       String email,
//       String name,
//       String role,
//       String passwordConfirmation,
//     ) async {
//       var dioregister = Dio();
//       var params = {
//         "username": username,
//         "password": password,
//         "email": email,
//         "name": name,
//         "role": role,
//         "passwordConfirmation": passwordConfirmation
//       };

//       try {
//         var response = await dioregister.post('/user', data: {
//           User(
//               name: name,
//               username: username,
//               email: email,
//               role: role,
//               password: password,
//               passwordConfirmation: passwordConfirmation),
//         });
//         if (response.statusCode == HttpStatus.ok) {
//           return User.fromMap(response.data);
//         } else {
//           throw response.data['data'];
//         }
//       } catch (e) {
//         throw Exception(e);
//       }
//     }
//   }
// }
