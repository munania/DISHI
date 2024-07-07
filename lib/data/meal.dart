import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class MealResponse {
  final List<Meal> meals;

  MealResponse({required this.meals});

  factory MealResponse.fromJson(Map<String, dynamic> json) =>
      _$MealResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MealResponseToJson(this);
}

@JsonSerializable()
class Meal {
  final String idMeal;
  final String strMeal;
  final String? strDrinkAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String strTags;
  final String strYoutube;
  List<String>? ingredients; // Nullable list
  List<String>? measures; // Nullable list

  Meal({
    required this.idMeal,
    required this.strMeal,
    this.strDrinkAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strTags,
    required this.strYoutube,
    this.ingredients,
    this.measures,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String>? ingredients = [];
    List<String>? measures = [];

    // Populate ingredients and measures
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(ingredient);
      }
      if (measure != null && measure.isNotEmpty) {
        measures.add(measure);
      }
    }

    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strDrinkAlternate: json['strDrinkAlternate'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients.isEmpty ? null : ingredients,
      measures: measures.isEmpty ? null : measures,
    );
  }

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
