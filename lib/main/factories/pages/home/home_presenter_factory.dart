import 'package:flutter_youtube_favorites/main/factories/factories.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

HomePresenter makeGetxHomePresenter() =>
    GetxHomePresenter(
        getVideosListUseCase: makeGetVideosList(),
        suggestionsListUseCase: makeSuggestionList()
    );
