// ignore_for_file: avoid_print

import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'dart:io';

class PostJounal extends StatefulWidget {
  const PostJounal({Key? key}) : super(key: key);

  @override
  _PostJounalState createState() => _PostJounalState();
}

class _PostJounalState extends State<PostJounal> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController abstrakController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  List<PlatformFile>? _files;

  void showProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

  void _openFileExplorer() async {
    _files = (await FilePicker.platform.pickFiles(
            type: FileType.any, allowMultiple: false, allowedExtensions: null))!
        .files;

    print('Loaded File Path is : ${_files!.first.path}');
  }

  void _uploadFile() async {
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

    Response response;

    String fileName = basename(_files.toString());
    print('File Base Name : $fileName');

    try {
      FormData formData = FormData.fromMap({
        'title': titleController.text,
        'author': authorController.text,
        'abstract': abstrakController.text,
        'category': categoryController.text,
        'file':
            await MultipartFile.fromFile(_files.toString(), filename: fileName),
      });
      response = await dio.post("journals", data: formData);
      print('File Upload Response : $response');
    } catch (e) {
      print('Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5E0),
        centerTitle: true,
        title: const Text(
          'Upload Journal',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Color(0xFF151515)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                autofocus: true,
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Title', icon: Icon(Icons.book)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                autofocus: true,
                controller: authorController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Author', icon: Icon(Icons.person)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                autofocus: true,
                controller: abstrakController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Abstract', icon: Icon(Icons.info)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                autofocus: true,
                controller: categoryController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Category', icon: Icon(Icons.category)),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
                icon: const Icon(Icons.upload),
                onPressed: _openFileExplorer,
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Colors.orange[100],
                  minimumSize: const Size(200, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.blueAccent)),
                ),
                label: const Text('Choose File')),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: _uploadFile,
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Colors.orange[100],
                  minimumSize: const Size(200, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.blueAccent)),
                ),
                child: const Text('Publish'))
          ],
        ),
      ),
    );
  }
}
