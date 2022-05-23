
import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../http/http.dart';

SuggestionsListUseCase makeSuggestionList() => SuggestionList(
  client: makeDioAdapter(),
  url: makeApiUrl(path: 'http://suggestqueries.google.com/complete/search?'),
);