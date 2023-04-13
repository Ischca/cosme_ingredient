import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cupertino_chip.dart';
import 'custom_alert_dialog.dart';

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
  final List<String> allBrands;
  final List<String> allTags;
  final List<String> allIngredients;
  final ValueChanged<FilterSelection> onChanged;
  final FilterSelection initialSelection;

  const FilterWidget({
    Key? key,
    required this.allBrands,
    required this.allTags,
    required this.allIngredients,
    required this.onChanged,
    required this.initialSelection,
  }) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<String> selectedBrands = [];
  List<String> selectedTags = [];
  List<String> selectedIngredients = [];

  @override
  void initState() {
    super.initState();
    selectedBrands = widget.initialSelection.brands.toList();
    selectedTags = widget.initialSelection.tags.toList();
    selectedIngredients = widget.initialSelection.ingredients.toList();
  }

  void _applyFilters() {
    final filters = FilterSelection(
      brands: selectedBrands.toList(),
      tags: selectedTags.toList(),
      ingredients: selectedIngredients.toList(),
    );

    if (mounted) {
      widget.onChanged(filters);
      Navigator.of(context).pop();
    }
  }

  void _resetFilters() {
    setState(() {
      selectedBrands.clear();
      selectedTags.clear();
      selectedIngredients.clear();
    });
  }

  bool canApplyFilters() {
    return selectedBrands.isNotEmpty || selectedTags.isNotEmpty || selectedIngredients.isNotEmpty;
  }

  CupertinoChip createChip(String text) {
    final isSelected = selectedBrands.contains(text);
    return CupertinoChip(
      label: text,
      selected: isSelected, // 追加
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            selectedBrands.add(text);
          } else {
            selectedBrands.remove(text);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: Text('フィルタリング'),
      content: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Text(
              'ブランド',
              style: CupertinoTheme.of(context)
                  .textTheme
                  .navLargeTitleTextStyle
                  .copyWith(
                fontSize: 22.0,
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.allBrands
                  .map(
                    (brand) => createChip(brand),
              ).toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'タグ',
              style: CupertinoTheme.of(context)
                  .textTheme
                  .navLargeTitleTextStyle
                  .copyWith(
                    fontSize: 22.0,
                  ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.allTags
                  .map(
                    (tag) => CupertinoChip(
                      label: tag,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            selectedTags.add(tag);
                          } else {
                            selectedTags.remove(tag);
                          }
                        });
                      },
                      selected: selectedTags.contains(tag),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              '成分',
              style: CupertinoTheme.of(context)
                  .textTheme
                  .navLargeTitleTextStyle
                  .copyWith(
                    fontSize: 22.0,
                  ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.allIngredients
                  .map(
                    (ingredient) => CupertinoChip(
                      label: ingredient,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            selectedIngredients.add(ingredient);
                          } else {
                            selectedIngredients.remove(ingredient);
                          }
                        });
                      },
                      selected:
                          selectedIngredients.contains(ingredient),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              color: CupertinoColors.inactiveGray,
              borderRadius: BorderRadius.circular(20),
              onPressed: () => Navigator.of(context).pop(),
            ),
            SizedBox(width: 4.0),
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Reset Filters',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              color: CupertinoColors.inactiveGray.withOpacity(canApplyFilters() ? 1 : 0.5),
              borderRadius: BorderRadius.circular(20),
              onPressed: canApplyFilters() ? _resetFilters : null,
            ),
            SizedBox(width: 4.0),
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Apply Filters',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              color: CupertinoColors.activeBlue,
              borderRadius: BorderRadius.circular(20),
              onPressed: _applyFilters,
            ),
          ],
        ),
      ],
    );
  }
}
