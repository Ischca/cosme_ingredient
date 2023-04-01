import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';
import 'package:cosme_ingredient/widgets/cosmetic_card.dart';
import 'package:flutter/material.dart';

import '../services/firestore_service.dart';
import '../widgets/search_bar.dart';
import 'package:cosme_ingredient/widgets/filter_widget.dart';


class SearchScreen extends StatefulWidget {
  SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Cosmetic> searchResults = [];
  final _firestoreService = FirestoreService();
  List<String> _selectedBrands = [];
  List<String> _selectedTags = [];
  List<String> _selectedIngredients = [];
  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();

    _loadResults();
  }

  Future<void> _loadResults() async {
    final results = await _firestoreService.searchCosmeticsWithFilters(
      brands: _selectedBrands,
      tags: _selectedTags,
      ingredients: _selectedIngredients,
      limit: 10,
      lastDocument: _lastDocument,
    );
    setState(() {
      searchResults.addAll(results);
      if (results.isNotEmpty) {
        _lastDocument = results.last.documentSnapshot;
      }
    });
  }

  // Future<void> _searchCosmetics(searchTerm) async {
  //   searchResults = await _firestoreService.searchCosmetics(searchTerm);
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cosme Ingredient'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.back,
            color: CupertinoColors.systemGrey,
          ),
        ),
// middle: SearchBar(
// onSubmitted: (value) {
// setState(() {
// _searchCosmetics(value);
// });
// },
// ),
        border: null,
        backgroundColor: Colors.white,
        transitionBetweenRoutes: false,
        automaticallyImplyLeading: false,
// trailing: GestureDetector(
// onTap: () {
// Navigator.pop(context);
// },
// child: Icon(
// CupertinoIcons.clear,
// color: CupertinoColors.systemGrey,
// ),
// ),
      ),
      child: Column(
        children: [
          FilterWidget(
            brands: _selectedBrands,
            tags: _selectedTags,
            ingredients: _selectedIngredients,
            onChanged: (filters) {
              setState(() {
                _selectedBrands = filters.brands;
                _selectedTags = filters.tags;
                _selectedIngredients = filters.ingredients;
                searchResults.clear();
                _lastDocument = null;
              });
              _loadResults();
            },
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification &&
                    scrollNotification.metrics.extentAfter == 0) {
                  _loadResults();
                  return true;
                }
                return false;
              },
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final cosmetic = searchResults[index];
                  return CosmeticCard(cosmetic: cosmetic);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}