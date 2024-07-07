import 'package:json_annotation/json_annotation.dart';

part 'meal_ingredients.g.dart';

@JsonSerializable()
class MealIngredients {
  String strMeal;
  String strMealThumb;
  String idMeal;

  MealIngredients({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory MealIngredients.fromJson(Map<String, dynamic> json) => _$MealIngredientsFromJson(json);

  Map<String, dynamic> toJson() => _$MealIngredientsToJson(this);
}
