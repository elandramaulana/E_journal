import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_journal/models/user.dart';
import 'package:e_journal/utils/user_preference.dart';
import 'package:e_journal/screens/home/widget/appbar_widget.dart';
import 'package:e_journal/screens/home/widget/numbers_widget.dart';
import 'package:e_journal/screens/home/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      backgroundColor: const Color(0xFFE4F5FF),
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.name,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          const NumbersWidget(),
          const SizedBox(height: 48),
          const Divider(
            thickness: 0.2,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(left: 30)),
              const Card(
                color: Colors.black,
                child: Icon(
                  Icons.download,
                  color: Colors.amber,
                  size: 35,
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 30)),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Download',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  )),
              const Padding(padding: EdgeInsets.only(right: 170)),
            ],
          ),
          const Divider(
            thickness: 0.2,
            color: Colors.black,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 47)),
              const Card(
                color: Colors.black,
                child: Icon(
                  Icons.logout,
                  color: Colors.amber,
                  size: 35,
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 30)),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  )),
              const Padding(padding: EdgeInsets.only(right: 170)),
            ],
          ),
          const Divider(
            thickness: 0.2,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );
}
