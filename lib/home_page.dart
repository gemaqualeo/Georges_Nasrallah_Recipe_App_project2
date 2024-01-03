import 'package:flutter/material.dart';
import 'recipe_card.dart';
import 'recipe.dart';
import 'search.dart';
import 'choseRecipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   bool _load = false; // used to show products list or progress bar
    List<Recipe> ? _recipes  ;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

   getRecipes()  async {
    _recipes = await ShowRecipe.getRecipe();
    if(_recipes != null) {
      setState(() {
        _load= true;
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Recipe App'),]
        ),actions: [
                 IconButton(onPressed: () {
                   showSearch(context: context, delegate: Search());
                },
                 icon: const Icon(Icons.search))
                 ],
             ),
        body: Visibility(
          visible: _load, replacement: const Center(
          child: CircularProgressIndicator(),
        ),
          child : ListView.builder(
          itemCount:
           _recipes?.length,
          itemBuilder: (context, i) {
            List<dynamic> chrecipe = [_recipes![i].name ,_recipes?[i].totaltime, _recipes?[i].imageUrl, _recipes?[i].rating];
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => choseRecipe( data: chrecipe ),
                    ),
                  );
                },
            child: RecipeCard(
                title: _recipes![i].name,
                cookTime: _recipes![i].totaltime,
                rating: _recipes![i].rating.toString(),
                thumbnailUrl: _recipes![i].imageUrl));
          },),
        )
    );
    }
  }
