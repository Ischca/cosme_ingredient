import 'package:cloud_firestore/cloud_firestore.dart';

class Cosmetic {
  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final String ingredients; // カンマ区切りの成分リスト

  Cosmetic({
    this.id = '',
    this.name = '',
    this.brand = '',
    this.imageUrl = '',
    required this.ingredients,
  });

  factory Cosmetic.fromJson(Map<String, dynamic> json) {
    return Cosmetic(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      imageUrl: json['imageUrl'],
      ingredients: json['ingredients'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
    };
  }

  // FirestoreのドキュメントをCosmeticオブジェクトに変換する
  factory Cosmetic.fromDocument(DocumentSnapshot doc) {
    return Cosmetic(
      id: doc.id,
      name: doc['name'],
      brand: doc['brand'],
      imageUrl: doc['imageUrl'],
      ingredients: doc['ingredients'],
    );
  }

  // CosmeticオブジェクトをFirestoreのドキュメントに変換する
  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
    };
  }
}
