import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionPage extends StatefulWidget {
  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _nutritionData;
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _fetchNutritionData(String foodItem) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Replace with your actual nutrition API credentials
      final String apiId = '390c170e';
      final String apiKey = 'f3f7338b2ed11c739a12d4396740c463	';

      final response = await http.post(
        Uri.parse('https://trackapi.nutritionix.com/v2/natural/nutrients'),
        headers: {
          'x-app-id': apiId,
          'x-app-key': apiKey,
          'Content-Type': 'application/json',
        },
        body: json.encode({'query': foodItem}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['foods'] != null && data['foods'].isNotEmpty) {
          setState(() {
            _nutritionData = data['foods'][0];
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'No nutrition information found.';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch nutrition data. Status code: ${response.statusCode}';
          _isLoading = false;
        });
        print('Response body: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Lookup'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter a food item (e.g., 1 cup rice)',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: Icon(Icons.food_bank, color: Colors.green.shade600),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.green.shade600),
                    onPressed: () => _fetchNutritionData(_searchController.text),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.green.shade300, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  isDense: true,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.red.shade300, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.red.shade300, width: 2),
                  ),
                ),
                style: TextStyle(fontSize: 16),
                onSubmitted: _fetchNutritionData,
              ),
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
                    ),
                  )
                : _errorMessage.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.red),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _errorMessage,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          ],
                        ),
                      )
                    : _nutritionData != null
                        ? _buildNutritionDetails()
                        : Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.restaurant_menu,
                                    size: 80,
                                    color: Colors.grey.shade300,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Search for a food item to see\nits nutritional information',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionDetails() {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.green.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.restaurant,
                          size: 40,
                          color: Colors.green.shade700,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        _nutritionData!['food_name'].toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_nutritionData!['serving_qty'] ?? 'N/A'} ${_nutritionData!['serving_unit'] ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                _buildCaloriesSection(),
                SizedBox(height: 24),
                _buildMacronutrientSection(),
                SizedBox(height: 24),
                _buildAdditionalNutrientsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCaloriesSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calories',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${_nutritionData!['nf_calories']?.toStringAsFixed(0) ?? 'N/A'}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                  fontSize: 30,
                ),
              ),
              Text(
                'kcal',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Icon(
            Icons.local_fire_department,
            size: 40,
            color: Colors.orange.shade400,
          ),
        ],
      ),
    );
  }

  Widget _buildMacronutrientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Macronutrients',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMacroCard(
                'Carbs',
                '${_nutritionData!['nf_total_carbohydrate']?.toStringAsFixed(1) ?? 'N/A'} g',
                Colors.amber,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildMacroCard(
                'Protein',
                '${_nutritionData!['nf_protein']?.toStringAsFixed(1) ?? 'N/A'} g',
                Colors.red.shade400,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildMacroCard(
                'Fat',
                '${_nutritionData!['nf_total_fat']?.toStringAsFixed(1) ?? 'N/A'} g',
                Colors.blue.shade400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalNutrientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Nutrients',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 16),
        _buildNutrientRow(
          'Dietary Fiber',
          '${_nutritionData!['nf_dietary_fiber']?.toStringAsFixed(1) ?? 'N/A'} g',
          Icons.grain,
        ),
        Divider(height: 24, thickness: 1, color: Colors.grey.shade200),
        _buildNutrientRow(
          'Sugars',
          '${_nutritionData!['nf_sugars']?.toStringAsFixed(1) ?? 'N/A'} g',
          Icons.icecream,
        ),
        Divider(height: 24, thickness: 1, color: Colors.grey.shade200),
        _buildNutrientRow(
          'Saturated Fat',
          '${_nutritionData!['nf_saturated_fat']?.toStringAsFixed(1) ?? 'N/A'} g',
          Icons.opacity,
        ),
        Divider(height: 24, thickness: 1, color: Colors.grey.shade200),
        _buildNutrientRow(
          'Sodium',
          '${_nutritionData!['nf_sodium']?.toStringAsFixed(0) ?? 'N/A'} mg',
          Icons.sanitizer,
        ),
      ],
    );
  }

  Widget _buildNutrientRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.green.shade700,
            size: 20,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.green.shade800,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}