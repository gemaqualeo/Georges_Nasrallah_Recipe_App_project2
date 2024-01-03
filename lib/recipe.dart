
import 'dart:convert';
import 'package:http/http.dart' as http;

class Recipe {
    final String name;
    final String ? imageUrl;
    final String rating;
    final String ? totaltime;


  Recipe({required this.name,  required this.imageUrl, required this.rating,required this.totaltime});

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    name: json["name"],
    rating: json["rating"],
    imageUrl: json["imageUrl"],
    totaltime: json["totaltime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "rating": rating,
    "imageUrl": imageUrl,
    "totalTime": totaltime,
  };

  @override
  String toString(){
    return 'Recipe {name: $name, image: $imageUrl, rating: $rating, totalTime: $totaltime}';
  }

}
List<Recipe> recipeFromJson(String str) => List<Recipe>.from(json.decode(str).map((x) => Recipe.fromJson(x)));
//String recipeToJson(List<Recipe> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ShowSearch{
  var data = [];
  List<Recipe> res = [] ;
  String _url = "https://georgesnasrallah.000webhostapp.com/search.php" ;
   Future<List<Recipe>?> getSearch({String ?query}) async {
    var url = Uri.parse(_url);
    try{
      var response = await http.get(url);

      if (response.statusCode == 200) {

        data = json.decode(response.body);
        res = data.map((e) => Recipe.fromJson(e)).toList();
        if (query!= null){
          res = res.where((element) => element.name!.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return res;
   }
}

/*
void updateProducts(Function(bool success) update) async {
  try {
    final uri = Uri.https(_url, 'showRecipe.php');
    final response = await http.get(uri)
        .timeout(const Duration(seconds: 5)); // max timeout 5 seconds
    recipe.clear(); // clear old products
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(response.body); // create dart json object from json array
      for (var row in jsonResponse) { // iterate over all rows in the json array
        Recipe r = Recipe( // create a product object from JSON row object
            name: row['name'],
            images: row['images'],
            rating: double.parse(row['rating']),
            totalTime: row['totalTime']);
        recipe.add(r); // add the product object to the _products list
      }
      update(true); // callback update method to inform that we completed retrieving data
    }
  }
  catch(e) {
    update(false); // inform through callback that we failed to get data
  }
}
*/
class ShowRecipe {
  static Future<List<Recipe>?> getRecipe() async {
    var client = http.Client();
    var url = Uri.parse('https://georgesnasrallah.000webhostapp.com/showRecipe.php');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      var json = response.body;
      return recipeFromJson(json);
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}

