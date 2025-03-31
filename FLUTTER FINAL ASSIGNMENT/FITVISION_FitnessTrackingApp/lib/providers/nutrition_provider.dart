import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/nutrition_model.dart';

class NutritionProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<NutritionItem> _nutritionItems = [];

  List<NutritionItem> get nutritionItems => _nutritionItems;

  Future<void> addNutritionItem(NutritionItem item) async {
    try {
      // Add to local list
      _nutritionItems.add(item);

      // Save to Firestore
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('nutrition_entries')
            .add(item.toFirestore());
      }

      notifyListeners();
    } catch (e) {
      print('Error adding nutrition item: $e');
    }
  }

  Future<void> removeNutritionItem(NutritionItem item) async {
    try {
      // Remove from local list
      _nutritionItems.remove(item);

      // Remove from Firestore (if possible to match)
      final user = _auth.currentUser;
      if (user != null) {
        final querySnapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('nutrition_entries')
            .where('name', isEqualTo: item.name)
            .where('calories', isEqualTo: item.calories)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          await querySnapshot.docs.first.reference.delete();
        }
      }

      notifyListeners();
    } catch (e) {
      print('Error removing nutrition item: $e');
    }
  }

  // Fetch nutrition items from Firestore
  Future<void> fetchNutritionItems() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final querySnapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('nutrition_entries')
            .orderBy('timestamp', descending: true)
            .get();

        _nutritionItems = querySnapshot.docs
            .map((doc) => NutritionItem.fromFirestore(doc))
            .toList();

        notifyListeners();
      }
    } catch (e) {
      print('Error fetching nutrition items: $e');
    }
  }

  // Calculation methods
  double getTotalCalories() {
    return _nutritionItems.fold(0.0, (sum, item) => sum + item.calories);
  }

  double getTotalProtein() {
    return _nutritionItems.fold(0.0, (sum, item) => sum + item.protein);
  }

  double getTotalCarbs() {
    return _nutritionItems.fold(0.0, (sum, item) => sum + item.carbs);
  }

  double getTotalFat() {
    return _nutritionItems.fold(0.0, (sum, item) => sum + item.fat);
  }
}