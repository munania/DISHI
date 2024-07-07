import 'package:json_annotation/json_annotation.dart';

part 'meal_id_search.g.dart';

@JsonSerializable()
class MealIdSearchResponse {
  @JsonKey(name: 'meals')
  final List<SearchIdMeal> searchMeals;

  MealIdSearchResponse({required this.searchMeals});

  factory MealIdSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$MealIdSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MealIdSearchResponseToJson(this);
}

@JsonSerializable()
class SearchIdMeal {
  final String idMeal;
  final String strMeal;
  final String? strDrinkAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String? strTags;
  final String strYoutube;
  @JsonKey(ignore: true)
  List<String>? ingredients;
  @JsonKey(ignore: true)
  List<String>? measures;

  SearchIdMeal({
    required this.idMeal,
    required this.strMeal,
    this.strDrinkAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strTags,
    required this.strYoutube,
    this.ingredients,
    this.measures,
  });

  factory SearchIdMeal.fromJson(Map<String, dynamic> json) {
    var meal = _$SearchIdMealFromJson(json);

    List<String> ingredients = [];
    List<String> measures = [];

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

    meal.ingredients = ingredients.isNotEmpty ? ingredients : null;
    meal.measures = measures.isNotEmpty ? measures : null;

    return meal;
  }

  Map<String, dynamic> toJson() => _$SearchIdMealToJson(this);
}