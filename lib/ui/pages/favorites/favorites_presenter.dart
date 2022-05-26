import '../../../data/models/models.dart';

abstract class FavoritePresenter {
  Stream<Map<String,VideoModel>> get favoriteListStream;

  Map<String,VideoModel> favorites = {};

  void setFavorites();
}
