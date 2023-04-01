import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosme_ingredient/screens/search_screen.dart';
import 'package:cosme_ingredient/widgets/search_bar.dart';
import 'package:cosme_ingredient/services/firestore_service.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';

import '../widgets/cosmetic_card.dart';
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
  }

  Future<void> _getCosmetics() async {
    List<Cosmetic> cosmetics = await _firestoreService.getCosmetics();
    setState(() {
      _cosmetics = cosmetics;
    });
  }

  Widget _buildCosmeticList() {
    return FutureBuilder<List<Cosmetic>>(
      future: _firestoreService.getCosmetics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Cosmetic> cosmetics = snapshot.data!;
            return ListView.builder(
              itemCount: cosmetics.length,
              itemBuilder: (context, index) {
                final cosmetic = cosmetics[index];
                return CosmeticCard(cosmetic: cosmetic);
              },
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cosme Ingredient'),
        trailing: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
          },
          child: Icon(
            CupertinoIcons.search,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
        child: Column(
        children: [
          Expanded(
            child: _buildCosmeticList(),
          ),
        ],
      ),
    );
  }
}
