import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../shared/shared.dart';
import '../../errors/errors.dart';

class VideoModel extends Equatable {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  const VideoModel(
      {required this.id,
      required this.title,
      required this.thumb,
      required this.channel});

  factory VideoModel.fromJson({required final Json json}) {
    if (json.keys.toSet().containsAll([
      'items',
    ])) {
      try {
        return VideoModel(
          id: "",
          channel: "",
          thumb: "",
          title: "",
        );
      } on ModelError {
        throw ModelError.remoteParseData(message: 'Erro ao buscar o video!');
      }
    } else {
      throw ModelError.remoteInvalidData(message: 'Erro ao buscar o video!');
    }
  }

  VideoEntity toEntity() => VideoEntity(
    id: "",
    channel: "",
    thumb: "",
    title: "",
      );

  @override
  List<Object> get props => [id,title,thumb, channel];
}
