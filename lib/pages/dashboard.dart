import 'package:flutter/material.dart';
import '../data/meal.dart';
import '../data/random_meal_api_fetch.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<MealResponse> futureMeal;

  @override
  void initState() {
    super.initState();
    futureMeal = fetchMeal();
  }

  void _refreshMeal() {
    setState(() {
      futureMeal = fetchMeal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildRefreshButton(),
            const SizedBox(height: 20),
            _buildMealDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return ElevatedButton(
      onPressed: _refreshMeal,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: AppColors.buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      ),
      child: const Text(
        "GET RANDOM MEAL",
        style: TextStyle(
          color: AppColors.buttonTextColor,
          fontSize: 16,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.not_interested, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No meal data available',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealDisplay() {
    return FutureBuilder<MealResponse>(
      future: futureMeal,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else if (snapshot.hasData) {
          if (snapshot.data!.meals.isNotEmpty) {
            return _buildMealList(snapshot.data!.meals);
          } else {
            return _buildNoDataWidget();
          }
        } else {
          return _buildNoDataWidget();
        }
      },
    );
  }

  Widget _buildErrorWidget(Object? error) {
    String errorMessage = 'An unexpected error occurred';

    if (error is Exception) {
      if (error is NetworkException) {
        errorMessage = 'Network error. Please check your internet connection.';
      } else if (error is ServerException) {
        errorMessage = 'Server error. Please try again later.';
      } else if (error is TimeoutException) {
        errorMessage = 'Request timed out. Please try again.';
      }
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _refreshMeal,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildMealList(List<Meal> meals) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      itemBuilder: (context, index) => MealCard(meal: meals[index]),
    );
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            "MY MEAL TODAY",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 20),
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderColor,
                width: 3,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.strMeal,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                _buildSectionTitle("Ingredients"),
                const SizedBox(height: 20),
                ...?meal.ingredients?.map((ingredient) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    ingredient,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
                const SizedBox(height: 10),
                _buildSectionTitle("Method of preparation"),
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
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class AppColors {
  static const Color buttonColor = Color.fromRGBO(231, 232, 134, 100);
  static const Color buttonTextColor = Color.fromRGBO(7, 33, 0, 100);
  static const Color borderColor = Color.fromRGBO(231, 232, 134, 100);
}