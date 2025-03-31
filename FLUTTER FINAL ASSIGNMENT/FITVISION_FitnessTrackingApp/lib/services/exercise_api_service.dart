import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/exercise_model.dart';

class ExerciseApiService {
  static const String _baseUrl = 'https://api.api-ninjas.com/v1/exercises';
  static const String _apiKey = 'w0A+fIj+4AurwRwGxlu4eA==1Vo7dQj9ukkMuZxZ'; // Replace with your actual API key

  Future<List<Exercise>> fetchExercisesByMuscle(String muscle) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?muscle=$muscle'),
        headers: {
          'X-Api-Key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Exercise.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Method to get unique muscle categories
  Future<List<String>> fetchMuscleCategories() async {
    // This is a mock implementation. In a real app, you might want to 
    // either hardcode these or fetch from a more comprehensive API
    return [
      'chest',
      'back',
      'shoulders',
      'arms',
      'legs',
      'abs',
    ];
  }
}