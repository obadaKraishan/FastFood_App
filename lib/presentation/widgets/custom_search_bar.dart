// lib/presentation/widgets/custom_search_bar.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final TextEditingController controller = TextEditingController();

  CustomSearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2A313F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'What do you want to eat today?',
          hintStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(FontAwesomeIcons.search, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
        onChanged: (query) {
          onSearch(query);
        },
      ),
    );
  }
}
