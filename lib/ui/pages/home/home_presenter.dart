import '../../../data/models/models.dart';

abstract class HomePresenter {


  Stream<List<VideoModel>> get videoResultsStream;

  Stream<Map<String,VideoModel>> get favoriteListStream;

  Map<String,VideoModel> favorites = {};

  Future<void> getVideos(String text);

  Future<void> nextPageVideos();

  Future<List> suggestions(String text);

  void toggleFavorite(VideoModel video);

  void saveFavorite();

}
