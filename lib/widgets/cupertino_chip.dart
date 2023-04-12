import 'package:flutter/cupertino.dart';

class CupertinoChip extends StatefulWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const CupertinoChip({
    Key? key,
    required this.label,
    required this.onSelected,
    this.selected = false,
  }) : super(key: key);

  @override
  _CupertinoChipState createState() => _CupertinoChipState();
}

class _CupertinoChipState extends State<CupertinoChip> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  void didUpdateWidget(CupertinoChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      setState(() {
        _selected = widget.selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelected(!_selected);
        setState(() {
          _selected = !_selected;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: _selected ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selected)
              Icon(
                CupertinoIcons.check_mark,
                size: 18.0,
                color: CupertinoColors.white,
              ),
            SizedBox(width: _selected ? 4.0 : 0),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 14.0,
                color: _selected ? CupertinoColors.white : CupertinoColors.label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
