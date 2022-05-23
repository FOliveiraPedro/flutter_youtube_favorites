import 'package:flutter_youtube_favorites/domain/entities/entities.dart';
import 'package:flutter_youtube_favorites/domain/helpers/helpers.dart';

import '../../../domain/usecases/usecases.dart';
import '../../errors/errors.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class SuggestionList implements SuggestionsListUseCase {
  final HttpClient client;
  final String url;

  SuggestionList({required this.client, required this.url});

  @override
  Future<List> call({required final String text}) async {
    try {
      var result =
          await client.request(url: url, method: Method.get, queryParameters: {
        'hl': 'en',
        'ds': 'yt',
        'client': 'youtube',
        'hjson': 't',
        'cp': 1,
        'q': text,
        'format': '5',
        'alt': 'json',

      });
      List list = result[1].map((map) {
        return map[0];
      }).toList();
      return list;
    } on CacheError catch (error) {
      throw error.toDomainError();
    } on ModelError catch (error) {
      throw error.toDomainError();
    }
  }
}
