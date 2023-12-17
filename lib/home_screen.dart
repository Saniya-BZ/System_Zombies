import 'dart:convert';
import 'recipeResponse.dart';
import 'diet_preference_screen.dart';
import 'recipeDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchEditingController = TextEditingController();
  String searchText = '';
  late Future<RecipeResponse> _recipeFuture;

  @override
  void initState() {
    super.initState();
    _recipeFuture = fetchData();
    searchEditingController.addListener(() {
      if (searchEditingController.text.isEmpty) {
        _refreshData();
      }
    });
  }

  Future<RecipeResponse> fetchData() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    String dietList = sharedPreferences.getString("Diet")!;
    String intoleranceList = sharedPreferences.getString("Intolerance")!;

    final Uri uri = Uri.parse('https://api.spoonacular.com/recipes/complexSearch');
    final Map<String, String> params = {
      'apiKey': '25073e0c5b7a4bdfbd7cb9021c0c3079', //e15e793e5316448a895329e55f9ee2f5
      'diet': dietList,
      'intolerances': intoleranceList,
      'number': '20',
      'query': searchText,
    };


    final Uri uriWithQuery = uri.replace(queryParameters: params);

    final response = await http.get(uriWithQuery);

    if (response.statusCode == 200) {

      return RecipeResponse.fromJson(json.decode(response.body));
    } else {

      throw Exception('Failed to load data');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      searchText = searchEditingController.text;
      _recipeFuture = fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0),
            elevation: 4,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 6,
                    child: TextField(
                      controller: searchEditingController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _refreshData();
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                        hintText: 'Enter Recipe Name',
                        hoverColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DietPreferenceScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.filter_alt_rounded,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<RecipeResponse>(
                future: _recipeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Display the data from the API
                    final recipeResponse = snapshot.data!;
                    if (recipeResponse.totalResults == 0) {
                      return Text("No Result Found!");
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: recipeResponse.results.length,
                      itemBuilder: (context, index) {
                        final recipe = recipeResponse.results[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetails(index: index, recipe: recipe),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                title: Text(recipe.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                                leading: Hero(
                                  tag: "image$index",
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        recipe.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(height: 2, color: ColorConstants.primaryColor),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
