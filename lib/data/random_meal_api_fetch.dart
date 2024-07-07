import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'meal.dart';

class NetworkException implements Exception {}
class ServerException implements Exception {}
class TimeoutException implements Exception {}

Future<MealResponse> fetchMeal() async {
  try {
    // Your existing fetch logic here
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        // print("My data");
        // print(jsonDecode(response.body));
      }

      return MealResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load meal data');
    }

  } catch (e) {
    if (e is SocketException || e is ClientException) {
      throw NetworkException();
    } else if (e is TimeoutException) {
      throw TimeoutException();
    } else {
      throw ServerException();
    }
  }
}