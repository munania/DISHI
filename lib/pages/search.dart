import 'package:dishi/pages/search_results.dart';
import 'package:flutter/material.dart';
import 'package:dishi/data/meal_ingredients.dart';

import '../data/search_meal_api_fetch.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();
  late Future<List<MealIngredients>> searchForMeal;

  @override
  void initState() {
    super.initState();
    searchForMeal = Future.value([]); // Initialize with an empty list
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 25),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 25,
                    height: 66,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(231, 232, 134, 100),
                        width: 3,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
                        hintText: 'Search by ingredient',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String searchTerm = searchController.text;
                      print(searchTerm);

                      setState(() {
                        searchForMeal = searchMeal(searchTerm);
                      });
                    },
                    child: const Text(
                      "Search for meal",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<MealIngredients>>(
              future: searchForMeal,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text("Ingredient not found. Please try again'"));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final meals = snapshot.data!;
                  return ListView.builder(
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            InkWell(
                              splashColor:
                                  const Color.fromRGBO(231, 232, 134, 100)
                                      .withAlpha(30),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SearchResults(
                                          mealId: meals[index].idMeal,
                                        )));
                              },
                              child: ListTile(
                                dense: false,
                                title: Text(
                                  meals[index].strMeal,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                leading:
                                    Image.network(meals[index].strMealThumb),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: Text(
                    'No meals found',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
