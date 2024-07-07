import 'dart:convert';
import 'package:dishi/data/meal_id_search.dart';
import 'package:http/http.dart' as http;

Future<MealIdSearchResponse> searchIdMeal(String searchTerm) async {
  final response = await http.get(Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$searchTerm'));

  if (response.statusCode == 200) {
    return MealIdSearchResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to search for meal data');
  }
}
