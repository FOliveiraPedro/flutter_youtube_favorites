import '../../../data/models/models.dart';
import '../../entities/entities.dart';

abstract class GetVideosListUseCase {
  Future<List<VideoModel>> call({required final String text});
  Future<List<VideoModel>> nextPage();
}