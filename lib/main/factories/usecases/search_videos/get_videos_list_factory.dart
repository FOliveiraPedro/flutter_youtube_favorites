
import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../http/http.dart';

GetVideosListUseCase makeGetVideosList() => GetVideosList(
  client: makeDioAdapter(),
  url: makeApiUrl(path: 'https://www.googleapis.com/youtube/v3/search?part=snippet'),
);