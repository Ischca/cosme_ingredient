import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';
import 'package:cosme_ingredient/services/firestore_service.dart';
import 'detail_screen.dart';

class AddCosmeticScreen extends StatefulWidget {
  static const routeName = '/add-cosmetic';

  @override
  _AddCosmeticScreenState createState() => _AddCosmeticScreenState();
}

class _AddCosmeticScreenState extends State<AddCosmeticScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = FirestoreService();
  String _name = '';
  String _brand = '';
  String _ingredients = '';
  String _imageUrl = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a new Cosmetic object with the input data
      final newCosmetic = Cosmetic(
        name: _name,
        brand: _brand,
        imageUrl: _imageUrl,
        ingredients: _ingredients,
      );

      // Save the new cosmetic to the database (this part will be implemented later)
      await _firestoreService.addCosmetic(newCosmetic);

      // Pop the screen and return the newCosmetic object
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CosmeticDetailScreen(cosmetic: newCosmetic),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('成分を分析するコスメを登録します'),
        trailing: GestureDetector(
          onTap: _submitForm,
          child: Text('登録'),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoTextFormFieldRow(
                  placeholder: 'ブランド',
                  onSaved: (value) => _brand = value!,
                ),
                CupertinoTextFormFieldRow(
                  placeholder: '名前',
                  onSaved: (value) => _name = value!,
                ),
                CupertinoTextFormFieldRow(
                  placeholder: '写真',
                  onSaved: (value) => _imageUrl = value!,
                ),
                CupertinoTextFormFieldRow(
                  placeholder: '成分',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '成分は必ず入力してください';
                    }
                    return null;
                  },
                  onSaved: (value) => _ingredients = value!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
