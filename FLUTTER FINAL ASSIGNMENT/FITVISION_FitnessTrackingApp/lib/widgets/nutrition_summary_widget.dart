import 'package:flutter/material.dart';

class NutritionSummaryWidget extends StatelessWidget {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  const NutritionSummaryWidget({
    Key? key,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.green[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNutrientColumn('Calories', calories, Colors.orange),
          _buildNutrientColumn('Protein', protein, Colors.blue),
          _buildNutrientColumn('Carbs', carbs, Colors.green),
          _buildNutrientColumn('Fat', fat, Colors.red),
        ],
      ),
    );
  }

  Widget _buildNutrientColumn(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
