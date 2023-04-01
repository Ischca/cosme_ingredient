import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';

class CosmeticDetailScreen extends StatelessWidget {
  static const routeName = '/cosmetic-detail';
  final Cosmetic cosmetic;

  CosmeticDetailScreen({required this.cosmetic});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(cosmetic.name),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add the cosmetic image if the imageUrl is not empty
              if (cosmetic.imageUrl.isNotEmpty)
                Center(
                  child: Image.network(
                    cosmetic.imageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return CircleAvatar();
                    },
                  ),
                ),
              SizedBox(height: 16),
              Text(
                cosmetic.brand,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                cosmetic.name,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 16),
              Text(
                '成分',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ...cosmetic.ingredients.map((ingredient) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(ingredient),
                );
              }).toList(),
            ],
          ),
// Add any other cosmetic information you'd like to display
        ),
      ),
    );
  }
}
