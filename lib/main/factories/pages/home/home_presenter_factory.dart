import 'package:flutter_youtube_favorites/main/factories/factories.dart';
import 'package:flutter_youtube_favorites/main/factories/usecases/search_videos/suggestions_list_factory.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

HomePresenter makeGetxHomePresenter() =>
    GetxHomePresenter(
        getVideosListUseCase: makeGetVideosList(),
        suggestionsListUseCase: makeSuggestionList()
    );
