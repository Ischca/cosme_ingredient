import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosme_ingredient/screens/search_screen.dart';
import 'package:cosme_ingredient/widgets/search_bar.dart';
import 'package:cosme_ingredient/services/firestore_service.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestoreService = FirestoreService();
  List<Cosmetic> _cosmetics = [];

  @override
  void initState() {
    super.initState();
    _getCosmetics();
  }

  Future<void> _getCosmetics() async {
    List<Cosmetic> cosmetics = await _firestoreService.getCosmetics();
    setState(() {
      _cosmetics = cosmetics;
    });
  }

  Widget _buildCosmeticList() {
    return ListView.builder(
      itemCount: _cosmetics.length,
      itemBuilder: (BuildContext context, int index) {
        final cosmetic = _cosmetics[index];

        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CosmeticDetailScreen(cosmetic: cosmetic),
              ),
            );
          },
          title: Text(cosmetic.name),
          subtitle: Text(cosmetic.brand),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(cosmetic.imageUrl),
          ),
        );
      },
    );
  }

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
          _buildCosmeticList(),
        ],
      ),
    );
  }
}
