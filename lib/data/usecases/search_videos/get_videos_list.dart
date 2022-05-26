import 'package:flutter_youtube_favorites/domain/helpers/helpers.dart';

import '../../../domain/usecases/usecases.dart';
import '../../errors/errors.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class GetVideosList implements GetVideosListUseCase {
  final HttpClient client;
  final String url;

  GetVideosList({required this.client, required this.url});

  String? _text;
  String? _nextPageToken;

  @override
  Future<List<VideoModel>> call({required final String text}) async {
    _text = text;
    try {
      var result =
          await client.request(url: url, method: Method.get, queryParameters: {
        'q': text,
        'type': 'video',
        'key': 'AIzaSyDEnfDiLGkMPW4MF4AyzDpYcF3QjQfj530',
        'maxResults': '10'
      });

      _nextPageToken = result['nextPageToken'];
      List<VideoModel> list = result['items'].map<VideoModel>((map) {
        return VideoModel.fromJson(json: map);
      }).toList();
      return list;
    } on CacheError catch (error) {
      throw error.toDomainError();
    } on ModelError catch (error) {
      throw error.toDomainError();
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<VideoModel>> nextPage() async {
    try {
      var result =
          await client.request(url: url, method: Method.get, queryParameters: {
        'q': _text,
        'type': 'video',
        'key': 'AIzaSyDEnfDiLGkMPW4MF4AyzDpYcF3QjQfj530',
        'maxResults': '10',
        'pageToken': _nextPageToken
      });
      _nextPageToken = result['nextPageToken'];
      List<VideoModel> list = result['items'].map<VideoModel>((map) {
        return VideoModel.fromJson(json: map);
      }).toList();
      return list;
    } on CacheError catch (error) {
      throw error.toDomainError();
    } on ModelError catch (error) {
      throw error.toDomainError();
    } catch (error) {
      throw error;
    }
  }
}
