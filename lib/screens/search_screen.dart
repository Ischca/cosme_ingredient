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
  List<String> allBrands = [
    '資生堂',
    'ランコム',
    'エスティローダー',
    'ディオール',
    'クリニーク',
    'シャネル',
    'SK-II',
    'キールズ',
    'ロレアル',
    'メイベリン',
  ];
  List<String> allTags = [
    'ファンデーション',
    'マスカラ',
    'リップスティック',
    'クレンジング',
    '化粧水',
    '乳液',
    '日焼け止め',
    '美容液',
    'アイクリーム',
    'ピーリング',
  ];
  List<String> allIngredients =  [
    'ヒアルロン酸',
    'ナイアシンアミド',
    'レチノール',
    'ビタミンC',
    'グリセリン',
    'アロエベラ',
    'サリチル酸',
    'グリコール酸',
    'セラミド',
    'ペプチド',
  ];
  List<String> _selectedBrands = [];
  List<String> _selectedTags = [];
  List<String> _selectedIngredients = [];


  @override
  void initState() {
    super.initState();

    _loadResults();
  }

  List<Cosmetic> _filterResults(List<Cosmetic> results) {
    return results.where((cosmetic) {
      if (_selectedBrands.isNotEmpty && !_selectedBrands.contains(cosmetic.brand)) {
        return false;
      }
      if (_selectedTags.isNotEmpty && !_selectedTags.any((tag) => cosmetic.tags.contains(tag))) {
        return false;
      }
      if (_selectedIngredients.isNotEmpty && !_selectedIngredients.any((ingredient) => cosmetic.ingredients.contains(ingredient))) {
        return false;
      }
      return true;
    }).toList();
  }

  Future<void> _loadResults() async {
    final results = await _firestoreService.getCosmetics();
    final filteredResults = _filterResults(results);

    setState(() {
      searchResults = filteredResults;
    });
  }

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return FilterWidget(
          allBrands: allBrands,
          allTags: allTags,
          allIngredients: allIngredients,
          onChanged: (filters) {
            _selectedBrands = filters.brands;
            _selectedTags = filters.tags;
            _selectedIngredients = filters.ingredients;
            _applyFilters();
          },
          initialSelection: FilterSelection(
            brands: _selectedBrands,
            tags: _selectedTags,
            ingredients: _selectedIngredients,
          ),
        );
      },
    );
  }

  void _applyFilters() {
    setState(() {
      searchResults.clear();
    });
    _loadResults();
  }

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
        border: null,
        backgroundColor: Colors.white,
        transitionBetweenRoutes: false,
        automaticallyImplyLeading: false,
        trailing: GestureDetector(
          onTap: _openFilterDialog,
          child: Icon(
            // CupertinoIcons.clear,
            CupertinoIcons.slider_horizontal_3,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
      child: Column(
        children: [
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