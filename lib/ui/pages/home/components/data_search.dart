import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/ui/pages/home/home.dart';

class DataSearch extends SearchDelegate<String> {
  final HomePresenter presenter;

  DataSearch({required this.presenter});


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = "";
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, "");
    }, icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,

    ));
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context,query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty)
      return Container();
    else {
      return FutureBuilder<List>(
        future: presenter.suggestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]),
                    leading: Icon(Icons.play_arrow),
                    onTap: (){
                      close(context, snapshot.data![index]);
                    },
                  );
                },
              itemCount: snapshot.data!.length,
            );
          }
        },
      );
    }
  }

}