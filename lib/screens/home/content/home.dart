import 'package:e_journal/screens/home/content/post_journal.dart';
import 'package:flutter/material.dart';

import '../placeholder/placeholder_card_short.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5E0),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PostJounal()));
            },
            icon: const Icon(Icons.add_circle),
            color: const Color(0xFF151313),
            iconSize: 35,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView.builder(
            itemCount: 9,
            itemBuilder: (content, index) {
              return const PlaceholderCardShort(
                  color: Color(0xFFE4F5FF), backgroundColor: Color(0xFFFEFFFF));
            }),
      ),
    );
  }
}
