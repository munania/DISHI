import 'dart:convert';
import 'package:dishi/data/meal_ingredients.dart';
import 'package:http/http.dart' as http;

Future<List<MealIngredients>> searchMeal(String searchTerm) async {
  final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?i=$searchTerm'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> mealsJson = data['meals'];

    List<MealIngredients> meals = mealsJson.map((json) => MealIngredients.fromJson(json)).toList();
    return meals;
  } else {
    throw Exception('Failed to search for meal data');
  }
}
