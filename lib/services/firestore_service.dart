import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';

import '../widgets/filter_widget.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _cosmeticsCollection = 'cosmetics';

  // Fetch all cosmetics
  Future<List<Cosmetic>> getCosmetics() async {
    QuerySnapshot snapshot = await _firestore.collection(_cosmeticsCollection).get();
    return snapshot.docs.map((doc) => Cosmetic.fromDocument(doc)).toList().cast<Cosmetic>();
  }

  // Add a new cosmetic
  Future<void> addCosmetic(Cosmetic cosmetic) async {
    await _firestore.collection(_cosmeticsCollection).add(cosmetic.toDocument());
  }

  // Update an existing cosmetic
  Future<void> updateCosmetic(String id, Cosmetic cosmetic) async {
    await _firestore.collection(_cosmeticsCollection).doc(id).update(cosmetic.toDocument());
  }

  // Delete a cosmetic
  Future<void> deleteCosmetic(String id) async {
    await _firestore.collection(_cosmeticsCollection).doc(id).delete();
  }

  Future<List<Cosmetic>> searchCosmetics(String searchTerm) async {
    QuerySnapshot snapshot = await _firestore
        .collection(_cosmeticsCollection)
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThanOrEqualTo: searchTerm + '\uf8ff')
        .get();
    return snapshot.docs.map((doc) => Cosmetic.fromDocument(doc)).toList().cast<Cosmetic>();
  }

  // Future<List<Cosmetic>> searchCosmeticsWithFilters(FilterSelection filters) async {
  //   Query query = _firestore.collection(_cosmeticsCollection);
  //   if (filters.brands.isNotEmpty) {
  //     for (int i = 0; i < filters.brands.length; i++) {
  //       query = query.where('brand', isEqualTo: filters.brands[i]);
  //     }
  //   }
  //   if (filters.tags.isNotEmpty) {
  //     for (int i = 0; i < filters.tags.length; i++) {
  //       query = query.where('tags', arrayContains: filters.tags[i]);
  //     }
  //   }
  //   if (filters.ingredients.isNotEmpty) {
  //     for (int i = 0; i < filters.ingredients.length; i++) {
  //       query = query.where('ingredients', arrayContains: filters.ingredients[i]);
  //     }
  //   }
  //   QuerySnapshot snapshot = await query.get();
  //   return snapshot.docs.map((doc) => Cosmetic.fromDocument(doc)).toList().cast<Cosmetic>();
  // }

  Future<List<Cosmetic>> searchCosmeticsWithFilters({
    List<String> brands = const [],
    List<String> tags = const [],
    List<String> ingredients = const [],
    int limit = 10,
    DocumentSnapshot? lastDocument,
  }) async {
    Query query = _firestore.collection(_cosmeticsCollection);

    if (brands.isNotEmpty) {
      query = query.where('brand', whereIn: brands);
    }

    if (tags.isNotEmpty) {
      for (final tag in tags) {
        query = query.where('tags', arrayContains: tag);
      }
    }

    if (ingredients.isNotEmpty) {
      for (final ingredient in ingredients) {
        query = query.where('ingredients', arrayContains: ingredient);
      }
    }

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final QuerySnapshot snapshot = await query.limit(limit).get();

    final List<Cosmetic> results = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Cosmetic.fromJson(data, documentSnapshot: doc);
    }).toList();

    return results;
  }
}
