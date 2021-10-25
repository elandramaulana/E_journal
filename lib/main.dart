import 'package:e_journal/screens/register/register.dart';
import 'package:e_journal/utils/preference_config.dart';
import 'package:flutter/material.dart';
import 'package:e_journal/screens/home/navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E_journal',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const Register(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const FluidNavBarDemo(),
        '/register': (BuildContext context) => const Register(),
      },
    );
  }
}
