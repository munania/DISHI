// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_id_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealIdSearchResponse _$MealIdSearchResponseFromJson(
        Map<String, dynamic> json) =>
    MealIdSearchResponse(
      searchMeals: (json['meals'] as List<dynamic>)
          .map((e) => SearchIdMeal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealIdSearchResponseToJson(
        MealIdSearchResponse instance) =>
    <String, dynamic>{
      'meals': instance.searchMeals,
    };

SearchIdMeal _$SearchIdMealFromJson(Map<String, dynamic> json) => SearchIdMeal(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strDrinkAlternate: json['strDrinkAlternate'] as String?,
      strCategory: json['strCategory'] as String,
      strArea: json['strArea'] as String,
      strInstructions: json['strInstructions'] as String,
      strMealThumb: json['strMealThumb'] as String,
      strTags: json['strTags'] as String?,
      strYoutube: json['strYoutube'] as String,
    );

Map<String, dynamic> _$SearchIdMealToJson(SearchIdMeal instance) =>
    <String, dynamic>{
      'idMeal': instance.idMeal,
      'strMeal': instance.strMeal,
      'strDrinkAlternate': instance.strDrinkAlternate,
      'strCategory': instance.strCategory,
      'strArea': instance.strArea,
      'strInstructions': instance.strInstructions,
      'strMealThumb': instance.strMealThumb,
      'strTags': instance.strTags,
      'strYoutube': instance.strYoutube,
    };
