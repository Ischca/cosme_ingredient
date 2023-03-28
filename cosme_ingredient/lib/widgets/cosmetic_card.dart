import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';
import 'package:cosme_ingredient/screens/detail_screen.dart';

class CosmeticCard extends StatelessWidget {
  final Cosmetic cosmetic;

  CosmeticCard({required this.cosmetic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => CosmeticDetailScreen(cosmetic: cosmetic),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cosmetic.brand,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              cosmetic.name,
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text(
              '成分: ${cosmetic.ingredients}',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
