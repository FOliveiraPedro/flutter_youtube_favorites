import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import '../../pages.dart';

class VideoTile extends StatelessWidget {
  final VideoModel video;
  final HomePresenter presenter;

  const VideoTile({Key? key, required this.video, required this.presenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      video.title,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      video.channel,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              )),
              StreamBuilder<Map<String,VideoModel>>(
                  stream: presenter.favoriteListStream,
                  initialData: {},
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                          onPressed: () {
                            presenter.toggleFavorite(video);
                          },
                          icon:  Icon(
                            snapshot.data!.containsKey(video.id)?
                            Icons.star:Icons.star_border,
                            color: Colors.white,
                            size: 30,
                          ));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          )
        ],
      ),
    );
  }
}
