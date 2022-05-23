import 'package:get/get.dart';

import '../../../data/models/models.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../helpers/helpers.dart';
import '../../../ui/pages/pages.dart';
import '../../mixins/mixins.dart';

class GetxHomePresenter extends GetxController with UIErrorManager implements HomePresenter {
  final GetVideosListUseCase getVideosListUseCase;
  final SuggestionsListUseCase suggestionsListUseCase;

  GetxHomePresenter({required this.getVideosListUseCase, required this.suggestionsListUseCase});

  Rx<List<VideoModel>> _videoResults = Rx<List<VideoModel>>([]);

  @override
  Stream<List<VideoModel>> get videoResultsStream => _videoResults.stream;
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
}
