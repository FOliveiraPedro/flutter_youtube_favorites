import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    throw [
      IconButton(onPressed: (){}, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    throw IconButton(onPressed: (){
      close(context, "");
    }, icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
      
    ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw Container();
  }
  
}