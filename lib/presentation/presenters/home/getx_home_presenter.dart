import 'dart:convert';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as Rxdart;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/models.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../helpers/helpers.dart';
import '../../../ui/pages/pages.dart';
import '../../mixins/mixins.dart';

class GetxHomePresenter extends GetxController with UIErrorManager implements HomePresenter {
  final GetVideosListUseCase getVideosListUseCase;
  final SuggestionsListUseCase suggestionsListUseCase;

  GetxHomePresenter({required this.getVideosListUseCase, required this.suggestionsListUseCase}){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains('favorites')) {
        favorites = json.decode(prefs.getString('favorites')!).map((k,v){
          return MapEntry(k, VideoModel.fromJson(json: v));
        }).cast<String,VideoModel>();
        _favoriteController.sink.add(favorites);
      }
    });
  }

  Rx<List<VideoModel>> _videoResults = Rx<List<VideoModel>>([]);

  @override
  Stream<List<VideoModel>> get videoResultsStream => _videoResults.stream;

  @override
  Map<String,VideoModel> favorites = {};

  final _favoriteController = Rxdart.BehaviorSubject<Map<String,VideoModel>>.seeded({});

  @override
  Stream<Map<String,VideoModel>> get favoriteListStream => _favoriteController.stream;

  List<VideoModel> list = [];
  @override
  Future<void> getVideos(String text) async {
    try {
      _videoResults.subject.add([]);
      list = await getVideosListUseCase.call(
        text: text
      );
      _videoResults.subject.add(list);

    } on DomainError catch (error) {
      snackbarError = error.fromDomain;
    }
  }

  @override
  Future<List> suggestions(String text) async {
    try {
      List list = await suggestionsListUseCase.call(
          text: text
      );
      return list;
    } on DomainError catch (error) {
      snackbarError = error.fromDomain;
      throw error;
    }
  }

  @override
  Future<void> nextPageVideos() async {
    try {
      list += await getVideosListUseCase.nextPage();
      _videoResults.subject.add(list);

    } on DomainError catch (error) {
      snackbarError = error.fromDomain;
    }
  }



  @override
  void saveFavorite(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString('favorites', json.encode(favorites));
    });
  }

  @override
  void toggleFavorite(VideoModel video){
    if(favorites.containsKey(video.id)){
      favorites.remove(video.id);
    }else{
      favorites[video.id] = video;
    }

    _favoriteController.sink.add(favorites);

    saveFavorite();
  }
}
