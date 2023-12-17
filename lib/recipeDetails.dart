import 'dart:convert';
import 'recipeResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeDetails extends StatefulWidget {
  RecipeDetails({Key? key, required this.index, required this.recipe}) : super(key: key);

  final int index;
  final Recipe recipe;

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late Future<Map<String, dynamic>> _recipeFuture;
  late String carbonEmissionText;
  late Color carbonEmissionColor;

  @override
  void initState() {
    super.initState();
    _recipeFuture = _fetchRecipeDetails();
  }

  Future<Map<String, dynamic>> _fetchRecipeDetails() async {
    final apiKey = 'e15e793e5316448a895329e55f9ee2f5';
    final apiUrl = 'https://api.spoonacular.com/recipes/${widget.recipe.id}/information';

    final response = await http.get(Uri.parse('$apiUrl?apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // Handle errors
      print('Failed to load recipe details. Status code: ${response.statusCode}');
      throw Exception('Failed to load recipe details');
    }
  }

  void calculateCarbonEmission(int healthScore) {
    if (healthScore >= 75) {
      carbonEmissionText = 'Low CO2 Emission';
      carbonEmissionColor = Colors.green;
    } else if (healthScore >= 50) {
      carbonEmissionText = 'Medium CO2 Emission';
      carbonEmissionColor = Colors.orange;
    } else {
      carbonEmissionText = 'High CO2 Emission';
      carbonEmissionColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
          future: _recipeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error loading recipe details'),
              );
            } else {
              final Map<String, dynamic> recipe = snapshot.data!;
              final int healthScore = recipe['healthScore'];

              calculateCarbonEmission(healthScore);

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'image${widget.index}',
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        color: Colors.blue,
                        child: Image.network(recipe['image'], fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${recipe['title']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          SizedBox(height: 8),

                          Text("Servings: ${recipe['servings']}"),
                          Text("Ready in ${recipe['readyInMinutes']} minutes"),

                          SizedBox(height: 16),
                          Text(
                            "Carbon Emission:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.eco,
                                color: carbonEmissionColor,
                              ),
                              SizedBox(width: 8),
                              Text(
                                carbonEmissionText,
                                style: TextStyle(
                                  color: carbonEmissionColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),


                          Text(
                            "Summary:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ), // Ingredients List
                          SizedBox(height: 16),
                          Text(
                            "Ingredients:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recipe['extendedIngredients']?.length ?? 0,
                            itemBuilder: (context, index) {
                              final ingredient = recipe['extendedIngredients'][index];
                              return ListTile(
                                title: Text("${ingredient['original']}"),
                              );
                            },
                          ),

                          // Nutrition Information
                          SizedBox(height: 16),
                          if (recipe['nutrition'] != null &&
                              recipe['nutrition']['nutrients'] != null)
                            Text(
                              "Nutrition Information:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          if (recipe['nutrition'] != null &&
                              recipe['nutrition']['nutrients'] != null)
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: recipe['nutrition']['nutrients'].length,
                              itemBuilder: (context, index) {
                                final nutrient = recipe['nutrition']['nutrients'][index];
                                return ListTile(
                                  title: Text("${nutrient['name']}: ${nutrient['amount']} ${nutrient['unit']}"),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
