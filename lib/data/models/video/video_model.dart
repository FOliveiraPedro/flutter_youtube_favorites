import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../shared/shared.dart';
import '../../errors/errors.dart';

class VideoModel extends Equatable {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  const VideoModel({required this.id,
    required this.title,
    required this.thumb,
    required this.channel});

  factory VideoModel.fromJson({required final Json json}) {
    try {
      if(json.containsKey('id')) {
        return VideoModel(
          id: json['id']['videoId'],
          channel: json['snippet']['channelTitle'],
          thumb: json['snippet']['thumbnails']['high']['url'],
          title: json['snippet']['title'],
        );
      }else{
        return VideoModel(
            id: json['videoId'],
            channel: json['channel'],
            thumb: json['thumb'],
            title: json['title']
        );
      }
    } on ModelError {
      throw ModelError.remoteParseData(message: 'Erro ao buscar o video!');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'videoId': id,
      'title': title,
      'thumb': thumb,
      'channel': channel
    };
  }

  VideoEntity toEntity() =>
      VideoEntity(
        id: "",
        channel: "",
        thumb: "",
        title: "",
      );

  @override
  List<Object> get props => [id, title, thumb, channel];
}
