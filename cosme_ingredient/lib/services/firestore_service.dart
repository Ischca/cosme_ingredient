import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosme_ingredient/models/cosmetic.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all cosmetics
  Future<List<Cosmetic>> getCosmetics() async {
    QuerySnapshot snapshot = await _firestore.collection('cosmetics').get();
    return snapshot.docs.map((doc) => Cosmetic.fromDocument(doc)).toList().cast<Cosmetic>();
  }

  // Add a new cosmetic
  Future<void> addCosmetic(Cosmetic cosmetic) async {
    await _firestore.collection('cosmetics').add(cosmetic.toDocument());
  }

  // Update an existing cosmetic
  Future<void> updateCosmetic(String id, Cosmetic cosmetic) async {
    await _firestore.collection('cosmetics').doc(id).update(cosmetic.toDocument());
  }

  // Delete a cosmetic
  Future<void> deleteCosmetic(String id) async {
    await _firestore.collection('cosmetics').doc(id).delete();
  }
}
