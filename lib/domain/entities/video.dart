import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  VideoEntity({required this.id, required this.title, required this.thumb, required this.channel});

  @override
  List<Object> get props => [id,title,thumb, channel];
}
