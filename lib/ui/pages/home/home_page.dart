import 'package:flutter/material.dart';

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
    widget.presenter.getVideos('gatos');
    _customScrollViewController = ScrollController();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Container(
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
            IconButton(onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            }, icon: const Icon(Icons.search))
          ],
        ),
        body: Padding(
          padding: MediaQuery.of(context).viewPadding,
          child: CustomScrollView(
            controller: _customScrollViewController,
            physics: const BouncingScrollPhysics(),
            slivers: const [
              SliverPadding(
                padding: EdgeInsets.all(24),
                sliver: SliverToBoxAdapter(
                  child: Text('Home Page'),
                ),
              ),
            ],
          ),
        ),
      );
}
