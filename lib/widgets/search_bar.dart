import 'package:flutter/cupertino.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onSubmitted;

  SearchBar({required this.onSubmitted});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      placeholder: '気になる商品の名前や成分の名前を入力してください...',
      onChanged: (value) {
        setState(() {
          searchTerm = value;
        });
      },
      onSubmitted: widget.onSubmitted,
    );
  }
}
