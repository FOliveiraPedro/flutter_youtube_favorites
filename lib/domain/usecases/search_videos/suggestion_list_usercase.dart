import '../../entities/entities.dart';

abstract class SuggestionsListUseCase {
  Future<List> call({required final String text});
}