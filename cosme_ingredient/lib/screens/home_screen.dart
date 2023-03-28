import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosme_ingredient/screens/search_screen.dart';
import 'package:cosme_ingredient/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cosme Ingredient'),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              onSubmitted: (searchTerm) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SearchScreen(searchTerm: searchTerm),
                  ),
                );
              },
            ),
          ),
          // Other widgets like categories, etc.
        ],
      ),
    );
  }
}
