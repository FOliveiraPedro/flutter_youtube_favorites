import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/domain/entities/entities.dart';
import 'package:flutter_youtube_favorites/ui/pages/home/components/video_tile.dart';

import '../../../data/models/models.dart';
import '../../mixins/mixins.dart';
import '../pages.dart';
import 'components/components.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({
    final Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _customScrollViewController;

  @override
  void initState() {
    super.initState();
    _customScrollViewController = ScrollController();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 25,
            child: Image.asset('lib/ui/assets/images/yt_logo_rgb_dark.png'),
          ),
          elevation: 0,
          backgroundColor: Colors.black87,
          actions: [
            const Align(
              alignment: Alignment.center,
              child: Text("0"),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
            IconButton(
                onPressed: () async {
                  String? result = await showSearch(
                      context: context,
                      delegate: DataSearch(presenter: widget.presenter));
                  widget.presenter.getVideos(result!);
                },
                icon: const Icon(Icons.search))
          ],
        ),
        backgroundColor: Colors.black87,
        body: Padding(
            padding: MediaQuery.of(context).viewPadding,
            child: StreamBuilder<List<VideoModel>>(
              stream: widget.presenter.videoResultsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      if(index < snapshot.data!.length) {
                        return VideoTile(video: snapshot.data![index]);
                      }else if(index > 1){
                        widget.presenter.nextPageVideos();
                        return Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                    itemCount: snapshot.data!.length+1,
                  );
                } else {
                  return Container();
                }
              },
            )),
      );
}
