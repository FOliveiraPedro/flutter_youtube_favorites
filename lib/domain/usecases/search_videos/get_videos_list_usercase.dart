import '../../entities/entities.dart';

abstract class GetVideosListUseCase {
  Future<List<VideoEntity>> call({required final String text});
}