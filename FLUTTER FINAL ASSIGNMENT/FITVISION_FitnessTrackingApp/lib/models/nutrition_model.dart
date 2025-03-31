import 'package:cloud_firestore/cloud_firestore.dart';

class NutritionItem {
  final String? id;
  final String name;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final DateTime? timestamp;

  NutritionItem({
    this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.timestamp,
  });

  // Factory constructor to create a NutritionItem from a Firestore document
  factory NutritionItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NutritionItem(
      id: doc.id,
      name: data['name'] ?? '',
      calories: (data['calories'] ?? 0.0).toDouble(),
      protein: (data['protein'] ?? 0.0).toDouble(),
      carbs: (data['carbs'] ?? 0.0).toDouble(),
      fat: (data['fat'] ?? 0.0).toDouble(),
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  // Convert NutritionItem to a map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : FieldValue.serverTimestamp(),
    };
  }

  // Getter for total macronutrients
  double get totalMacronutrients => protein + carbs + fat;

  @override
  String toString() {
    return 'NutritionItem(name: $name, calories: $calories, protein: $protein, carbs: $carbs, fat: $fat)';
  }
}