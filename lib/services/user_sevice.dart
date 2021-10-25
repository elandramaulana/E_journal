import 'dart:io';
import 'package:e_journal/models/user.dart';
import 'package:e_journal/services/api_service.dart';

const createUserPath = 'user';

class UserService extends ApiService {
  Future<User> createUser(
    String email,
    String username,
    String name,
    String password,
    String passwordConfirmation,
    String role,
  ) async {
    var params = {
      "email": email,
      "username": username,
      "name": name,
      "password": password,
      "passwordConfirmation": passwordConfirmation,
      "role": role,
    };
    try {
      final response = await postRequest(createUserPath, params);
      if (response.statusCode == HttpStatus.ok) {
        return User.fromMap(response.data);
      } else {
        throw response.data;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}














// class UserService extends ApiService {
//   Future<User> createUser(
//     String username,
//     String password,
//     String email,
//     String name,
//     String role,
//     String passwordConfirmation,
//   ) async {
//     var dioregister = Dio();
//     var params = {
//       "username": username,
//       "password": password,
//       "email": email,
//       "name": name,
//       "role": role,
//       "passwordConfirmation": passwordConfirmation
//     };
//     try {
//       final response = await dioregister.post('user',
//           data: {"username": username, "password": password, "email": email});
//       if (response.statusCode == HttpStatus.ok) {
//         return User.fromMap(response.data);
//       } else {
//         throw response.data['data'];
//       }
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
