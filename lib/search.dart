import 'package:flutter/material.dart';
import 'recipe.dart';

class Search extends SearchDelegate {
  ShowSearch rlist = ShowSearch();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }
          , icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {
      Navigator.pop(context);
    },);
  }


  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Recipe>?>(
        future: ShowRecipe.getRecipe(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator()
            );
          }
          List<Recipe>? data = snapshot.data;
          List<Recipe>? filteredData = data
              ?.where((recipe) =>
              recipe.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ListView.builder(
              itemCount: filteredData?.length,
              itemBuilder: (context, i) {
                return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                            title: Row(
                                children: [
                                  Expanded(child:
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          '${filteredData?[i].name}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.clip),

                                        )
                                      ]

                                  ),)
                                ])))
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        child: FutureBuilder<List<Recipe>?>(
            future: ShowRecipe.getRecipe(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator()
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No results found.'),
                );
              }
              else {
                return ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, i) {
                      return Card(
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                  title: Row(
                                      children: [
                                        const SizedBox(width: 30),
                                        Expanded(child:
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                '${data?[i].name}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight
                                                        .w600),
                                                overflow: TextOverflow.fade,
                                              ),
                                            ]
                                        ),
                                        )
                                      ])))
                      );
                    });
              }
            }
        )
    );
  }
}
