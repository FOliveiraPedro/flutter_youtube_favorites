import 'package:get/get.dart';

import '../../../data/models/models.dart';
import '../../../domain/entities/entities.dart';
import '../../helpers/helpers.dart';

abstract class HomePresenter {


  Stream<List<VideoModel>> get videoResultsStream;

  Future<void> getVideos(String text);

  Future<void> nextPageVideos();

  Future<List> suggestions(String text);
}
