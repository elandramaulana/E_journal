import 'package:e_journal/screens/login/login.dart';
// import 'package:e_journal/services/service_register.dart';
import 'package:e_journal/services/user_sevice.dart';
import 'package:flutter/material.dart';
import 'package:e_journal/components/background.dart';
import 'package:e_journal/utils/constanta.dart';
import 'package:e_journal/utils/validation.dart';
import 'package:e_journal/utils/preference_config.dart';
import 'package:e_journal/screens/home/navbar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final rNameController = TextEditingController();
  final rUnameController = TextEditingController();
  final rEmailController = TextEditingController();
  final rRoleController = TextEditingController();
  final rPwdController = TextEditingController();
  final rPwdConfirmationController = TextEditingController();
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isFetchingData = false;

  @override
  void iniState() {
    getDataPreference();
    super.initState();
  }

  @override
  void dispose() {
    rNameController.dispose();
    rUnameController.dispose();
    rEmailController.dispose();
    rPwdController.dispose();
    rPwdConfirmationController.dispose();
    super.dispose();
  }

  getDataPreference() async {
    await Future.delayed(const Duration(seconds: 2));
    String id = PreferencesConfig.getString(USER_ID_KEY);
    if (id.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  // Widget textFieldCustom(
  //     {@required TextEditingController? controller,
  //     @required String? hint,
  //     label,
  //     bool isDataValid = true}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: TextField(
  //       controller: controller,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         hintText: hint,
  //         errorText: isDataValid ? null : "Format tidak sesuai",
  //         errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
  //         border: const OutlineInputBorder(
  //             borderSide: BorderSide(color: Colors.teal)),
  //       ),
  //     ),
  //   );
  // }

  createUser(String name, String email, String password, String username,
      String role, String passwordConfirmation) async {
    setState(() {
      isFetchingData = true;
    });
    final service = UserService();
    try {
      final user = await service.createUser(
          name, email, password, username, role, passwordConfirmation);
      PreferencesConfig.setString(USER_EMAIL_KEY, user.email);
      PreferencesConfig.setString(USER_NAME_KEY, user.name);
      PreferencesConfig.setString(USERNAME_KEY, user.username);
      // PreferencesConfig.setString(USER_ROLE_KEY, user.role.toString());
      PreferencesConfig.setString(USER_PASSWORD_KEY, user.password);
      PreferencesConfig.setString(
          USER_CONFIRM_PASSWORD_KEY, user.passwordConfirmation);
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                e.toString(),
                maxLines: 5,
              ),
              content: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Try again'),
              ),
            );
          });
    }
    setState(() {
      isFetchingData = false;
    });
  }

  onCreateUser() {
    String username = rUnameController.text;
    String email = rEmailController.text;
    String name = rNameController.text;
    String pass = rPwdController.text;
    String confPass = rPwdConfirmationController.text;
    String role = rRoleController.text;
    if (EmailVal().isEmailValid(email)) {
      setState(() {
        isEmailValid = true;
      });
      createUser(email, username, name, pass, confPass, role);
    } else {
      setState(() {
        isEmailValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 120.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'REGISTER',
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
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: rEmailController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Email",
                  icon: Icon(Icons.email),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: rUnameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Username", icon: Icon(Icons.group)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: rNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Name", icon: Icon(Icons.group)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: rPwdController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Password", icon: Icon(Icons.lock)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: rPwdConfirmationController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Confirm Password", icon: Icon(Icons.lock)),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: isFetchingData ? null : onCreateUser,
                child: isFetchingData
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Colors.orange[100],
                  minimumSize: const Size(200, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.blueAccent)),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Login()))
                },
                child: const Text(
                  "Already Have an Account? Sign in",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
