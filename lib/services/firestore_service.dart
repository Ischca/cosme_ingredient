import 'dart:convert';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';
import 'package:cosme_ingredient/config/data_cache.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _cosmeticsCollection = 'cosmetics';
  final String _cosmeticsCacheKey = 'cosmetics_cache';
  late DataCache _dataCache;

  FirestoreService(BuildContext context) {
    _dataCache = Provider.of<DataCache>(context, listen: false);
  }

  // Fetch all cosmetics
  Future<List<Cosmetic>> getCosmetics() async {
    Result<List<dynamic>?> cachedDataResult = await _dataCache.getCachedData(_cosmeticsCacheKey);
    if (cachedDataResult.isValue && cachedDataResult.asValue!.value != null) {
      List<dynamic> cachedData = cachedDataResult.asValue!.value!;
      return cachedData.map((json) => Cosmetic.fromJson(json)).toList().cast<Cosmetic>();
    } else {
      QuerySnapshot snapshot = await _firestore.collection(_cosmeticsCollection).get();
      List<Cosmetic> cosmetics = snapshot.docs.map((doc) => Cosmetic.fromDocument(doc)).toList().cast<Cosmetic>();
      _dataCache.cacheData(_cosmeticsCacheKey, cosmetics.map((cosmetic) => cosmetic.toJson()).toList());
      return cosmetics;
    }
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
}
