import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Filter by Category'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to category filter options
            },
          ),
          ListTile(
            title: Text('Filter by Price'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to price filter options
            },
          ),
          ListTile(
            title: Text('Filter by Rating'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to rating filter options
            },
          ),
          ListTile(
            title: Text('Filter by Distance'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to distance filter options
            },
          ),
        ],
      ),
    );
  }
}
