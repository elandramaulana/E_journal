import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_journal/screens/register/register.dart';
import 'package:e_journal/components/background.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class ServiceLogin {
  Future<dynamic> loginUser(String username, String password) async {
    final _dio = Dio();
    _dio.options
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

    _dio.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (options, handler) {
          // return handler.resolve( Response(data:"xxx"));
          // return handler.reject( DioError(message: "eh"));
          return handler.next(options);
        },
      ))
      ..add(LogInterceptor(responseBody: false)); //Open log;

    var response = await _dio.post(
      'authenticate',
      data: {"username": username, "password": password},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    // ignore: avoid_print
    print(response.data);
  }
}

class _LoginState extends State<Login> {
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  TextEditingController unameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  login() async {
    var uname = unameController.text;
    var pwd = pwdController.text;
    var service = ServiceLogin();
    try {
      await service.loginUser(uname, pwd).then((function) {});
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    {
      // Home.routeName : (context)
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  focusNode: _usernameFocusNode,
                  autofocus: true,
                  controller: unameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'Username', icon: Icon(Icons.person)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  focusNode: _passwordFocusNode,
                  autofocus: true,
                  controller: pwdController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', icon: Icon(Icons.lock)),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      primary: Colors.orange[100],
                      minimumSize: const Size(200, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: Colors.blueAccent)),
                    ),
                    child: const Text('Login')),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()))
                  },
                  child: const Text(
                    "Don't Have an Account? Sign up",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
