import 'package:flutter/material.dart';

class OrderNoteWidget extends StatelessWidget {
  final TextEditingController noteController;

  OrderNoteWidget({required this.noteController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add a Note', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),
        TextField(
          controller: noteController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Add any special instructions here',
            hintStyle: TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Color(0xFF2A313F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
