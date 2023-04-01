import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterSelection {
  final List<String> brands;
  final List<String> tags;
  final List<String> ingredients;

  FilterSelection({
    required this.brands,
    required this.tags,
    required this.ingredients,
  });
}

class FilterWidget extends StatefulWidget {
  final List<String> brands;
  final List<String> tags;
  final List<String> ingredients;
  final ValueChanged<FilterSelection> onChanged;

  const FilterWidget({
    Key? key,
    required this.brands,
    required this.tags,
    required this.ingredients,
    required this.onChanged,
  }) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<String> selectedBrands = [];
  List<String> selectedTags = [];
  List<String> selectedIngredients = [];

  void _applyFilters() {
    final filters = FilterSelection(
      brands: selectedBrands.toList(),
      tags: selectedTags.toList(),
      ingredients: selectedIngredients.toList(),
    );

    widget.onChanged(filters);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Brands',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.brands
              .map((brand) => FilterChip(
            label: Text(brand),
            selected: selectedBrands.contains(brand),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  selectedBrands.add(brand);
                } else {
                  selectedBrands.remove(brand);
                }
              });
            },
          ))
              .toList(),
        ),
        SizedBox(height: 16.0),
        Text(
          'Tags',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.tags
              .map((tag) => FilterChip(
            label: Text(tag),
            selected: selectedTags.contains(tag),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  selectedTags.add(tag);
                } else {
                  selectedTags.remove(tag);
                }
              });
            },
          ))
              .toList(),
        ),
        SizedBox(height: 16.0),
        Text(
          'Ingredients',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.ingredients
              .map((ingredient) => FilterChip(
            label: Text(ingredient),
            selected: selectedIngredients.contains(ingredient),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  selectedIngredients.add(ingredient);
                } else {
                  selectedIngredients.remove(ingredient);
                }
              });
            },
          ))
              .toList(),
        ),
        SizedBox(height: 16.0),
        CupertinoButton.filled(
          child: Text('Apply Filters'),
          onPressed: _applyFilters,
        ),
      ],
    );
  }
}
