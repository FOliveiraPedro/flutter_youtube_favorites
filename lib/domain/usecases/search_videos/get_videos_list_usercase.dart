import '../../../data/models/models.dart';

abstract class GetVideosListUseCase {
  Future<List<VideoModel>> call({required final String text});
  Future<List<VideoModel>> nextPage();
}