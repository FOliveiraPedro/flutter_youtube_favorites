import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:get/get.dart';
import '../../../data/models/models.dart';
import '../pages.dart';

class FavoritesPage extends StatefulWidget {
  final FavoritePresenter presenter;

  const FavoritesPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    widget.presenter.favorites = Get.arguments;
    widget.presenter.setFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, VideoModel>>(
          stream: widget.presenter.favoriteListStream,
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data!.values.map((v) {
                return InkWell(
                  onTap: (){
                    FlutterYoutube.playYoutubeVideoById(apiKey: 'AIzaSyDEnfDiLGkMPW4MF4AyzDpYcF3QjQfj530', videoId: v.id);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(child: Text(
                        v.title,style: TextStyle(color: Colors.white70),
                        maxLines: 2,
                      ))
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
