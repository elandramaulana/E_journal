import 'package:flutter/material.dart';
import '../placeholder/placeholder_card_tall.dart';

class BookmarkContent extends StatelessWidget {
  const BookmarkContent({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ListView.builder(
        itemCount: 9,
        itemBuilder: (content, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const PlaceholderCardTall(
                height: 200,
                color: Color(0xFFE4F5FF),
                backgroundColor: Color(0xFFFEFFFF)),
          );
        },
      ),
    );
  }
}
