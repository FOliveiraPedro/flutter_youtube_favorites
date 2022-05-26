import 'package:flutter_youtube_favorites/data/models/video/video_model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../../../ui/pages/favorites/favorites_presenter.dart';
import '../../mixins/mixins.dart';

class GetxFavoritesPresenter extends GetxController with UIErrorManager implements FavoritePresenter {

  GetxFavoritesPresenter();

  @override
  Map<String, VideoModel> favorites = {};

  final _favoriteController = BehaviorSubject<Map<String,VideoModel>>.seeded({});

  @override
  Stream<Map<String, VideoModel>> get favoriteListStream => _favoriteController.stream;

  @override
  void setFavorites() {
    _favoriteController.sink.add(favorites);
  }

}
