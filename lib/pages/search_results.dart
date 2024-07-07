import 'package:dishi/data/meal_id_search_api.dart';
import 'package:flutter/material.dart';
import '../data/meal_id_search.dart';

class SearchResults extends StatefulWidget {
  final mealId;
  const SearchResults({super.key, required this.mealId});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late Future<MealIdSearchResponse> futureMeal;

  @override
  void initState() {
    super.initState();
    futureMeal = searchIdMeal(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<MealIdSearchResponse>(
                future: futureMeal,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                      'Ingredient not found. Please try again',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ));
                  } else if (snapshot.hasData) {
                    final meals = snapshot.data!.searchMeals;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        final meal = meals[index];
                        final List<String> ingredients = meal.ingredients ?? [];
                        final List<String> measures = meal.measures ?? [];

                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, bottom: 20),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 20,
                                        bottom: 10,
                                        right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            231, 232, 134, 100),
                                        width: 3,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              meal.strMeal,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            // ElevatedButton(
                                            //   onPressed: () {
                                            //   },
                                            //   style: ElevatedButton.styleFrom(
                                            //     shape: const RoundedRectangleBorder(
                                            //       borderRadius: BorderRadius.all(Radius.circular(20)),
                                            //     ),
                                            //     backgroundColor: const Color.fromRGBO(231, 232, 134, 100),
                                            //     padding: const EdgeInsets.only(
                                            //       left: 24,
                                            //       top: 18,
                                            //       right: 24,
                                            //       bottom: 18,
                                            //     ),
                                            //   ),
                                            //   child: const Text(
                                            //     "Narrate Menu",
                                            //     style: TextStyle(
                                            //       color: Color.fromRGBO(7, 33, 0, 100),
                                            //       fontSize: 12,
                                            //       fontFamily: "Montserrat",
                                            //       fontWeight: FontWeight.w600,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Ingredients",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ...List.generate(ingredients.length,
                                            (i) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Text(
                                              "${measures[i]} ${ingredients[i]}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        }),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Method of preparation",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          meal.strInstructions,
                                          style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
