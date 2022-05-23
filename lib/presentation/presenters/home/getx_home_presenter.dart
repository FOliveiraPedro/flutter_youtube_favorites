import 'package:flutter_youtube_favorites/presentation/mixins/ui_error_manager.dart';
import 'package:get/get.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../helpers/helpers.dart';
import '../../../ui/pages/pages.dart';

class GetxHomePresenter extends GetxController with UIErrorManager implements HomePresenter {
  final GetVideosListUseCase getVideosListUseCase;

  GetxHomePresenter({required this.getVideosListUseCase});

  @override
  Future<void> getVideos(String text) async {
    try {
      await getVideosListUseCase.call(
        text: text
      );
    } on DomainError catch (error) {
      snackbarError = error.fromDomain;
      // '${error.message} [${error.code}]';
    }
  }
}
