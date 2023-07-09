import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  //const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Center(
        child: Text('Search...'),
      ),
    );
  }
}
