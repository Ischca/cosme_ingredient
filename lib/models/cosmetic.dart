import 'package:cloud_firestore/cloud_firestore.dart';

class Cosmetic {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> tags;
  final String brand;
  final String description;
  final DocumentSnapshot? documentSnapshot;

  Cosmetic({
    this.id = '',
    this.name = '',
    this.brand = '',
    this.imageUrl = '',
    required this.ingredients,
    this.tags = const [],
    this.description = '',
    this.documentSnapshot,
  });

  factory Cosmetic.fromJson(Map<String, dynamic> json, {DocumentSnapshot? documentSnapshot}) {
    return Cosmetic(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      description: json['description'] ?? '',
      documentSnapshot: documentSnapshot,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'tags': tags,
      'description': description,
    };
  }

  // FirestoreのドキュメントをCosmeticオブジェクトに変換する
  factory Cosmetic.fromDocument(DocumentSnapshot doc) {
    return Cosmetic(
      id: doc.id,
      name: doc['name'],
      brand: doc['brand'],
      imageUrl: doc['imageUrl'],
      ingredients: List<String>.from(doc['ingredients'] ?? []),
      tags: List<String>.from(doc['tags'] ?? []),
      description: doc['description'],
      documentSnapshot: doc,
    );
  }

  // CosmeticオブジェクトをFirestoreのドキュメントに変換する
  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'tags': tags,
      'description': description,
    };
  }

  static List<String> detectSeparators(String text, {int n = 100}) {
    // 最初のn文字を取得する
    final sample = text.substring(0, n);
    print(sample);

    // 取得した文字列から、単語を区切るためによく使用される文字を検出する
    final separators = RegExp(r'[\s\.,;:!?\(\)]+')
        .allMatches(sample)
        .map((match) => match.group(0))
        .where((element) => element != null)
        .toList();

    print(separators);

    // 頻度の高い文字を取得する
    final frequency = <String, int>{};
    for (final separator in separators) {
      frequency[separator!] = (frequency[separator] ?? 0) + 1;
    }

    print(frequency);

    // 出現頻度が多い順に並び替えて、区切り文字として使用される可能性のある文字のリストを返す
    final sorted = frequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final separator = sorted.take(5).map((e) => e.key).toList().first ?? '';

    if (separator.isEmpty) {
      return [text];
    } else {
      return text.split(separator);
    }
  }
}
