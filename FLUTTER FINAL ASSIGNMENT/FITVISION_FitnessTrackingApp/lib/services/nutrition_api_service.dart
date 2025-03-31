// lib/services/nutrition_api_service.dart
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import '../models/nutrition_model.dart';

class NutritionApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _baseUrl = 'https://api.nutritionix.com/v1_1/search/';
  static const String _apiKey = 'f3f7338b2ed11c739a12d4396740c463';
  static const String _appId = '390c170e';

  Future<NutritionItem?> fetchNutritionData(String foodItem) async {
    // First, try to fetch from Firestore cache
    try {
      final cachedDoc = await _firestore
          .collection('nutrition_cache')
          .doc(foodItem.toLowerCase())
          .get();

      if (cachedDoc.exists) {
        return NutritionItem(
          name: cachedDoc.data()?['name'] ?? foodItem,
          calories: (cachedDoc.data()?['calories'] ?? 0).toDouble(),
          protein: (cachedDoc.data()?['protein'] ?? 0).toDouble(),
          carbs: (cachedDoc.data()?['carbs'] ?? 0).toDouble(),
          fat: (cachedDoc.data()?['fat'] ?? 0).toDouble(),
        );
      }
    } catch (e) {
      print('Firestore cache error: $e');
    }

    // If not in cache, fetch from Nutritionix API
    final url = Uri.parse('$_baseUrl$foodItem?fields=item_name,nf_calories,nf_protein,nf_total_carbohydrate,nf_total_fat&appId=$_appId&appKey=$_apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['hits'] != null && data['hits'].length > 0) {
          final nutritionData = data['hits'][0]['fields'];
          
          final nutritionItem = NutritionItem(
            name: nutritionData['item_name'],
            calories: nutritionData['nf_calories'] ?? 0,
            protein: nutritionData['nf_protein'] ?? 0,
            carbs: nutritionData['nf_total_carbohydrate'] ?? 0,
            fat: nutritionData['nf_total_fat'] ?? 0,
          );

          // Cache the result in Firestore
          await _firestore
              .collection('nutrition_cache')
              .doc(foodItem.toLowerCase())
              .set({
            'name': nutritionItem.name,
            'calories': nutritionItem.calories,
            'protein': nutritionItem.protein,
            'carbs': nutritionItem.carbs,
            'fat': nutritionItem.fat,
            'timestamp': FieldValue.serverTimestamp(),
          });

          return nutritionItem;
        }
      }
      return null;
    } catch (e) {
      print('Error fetching nutrition data: $e');
      return null;
    }
  }
}