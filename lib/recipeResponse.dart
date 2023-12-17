class RecipeResponse {
  int offset;
  int number;
  List<Recipe> results;
  int totalResults;

  RecipeResponse({
    required this.offset,
    required this.number,
    required this.results,
    required this.totalResults,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    return RecipeResponse(
      offset: json['offset'],
      number: json['number'],
      results: List<Recipe>.from(json['results'].map((result) => Recipe.fromJson(result))),
      totalResults: json['totalResults'],
    );
  }
}

class Recipe {
  int id;
  String title;
  String image;
  String imageType;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      imageType: json['imageType'],
    );
  }
}
