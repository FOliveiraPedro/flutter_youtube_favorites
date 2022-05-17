import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_youtube_favorites/app_module.dart';
import 'package:flutter_youtube_favorites/app_widget.dart';

void main() {
  runApp(const FLutterTube());
}

class FLutterTube extends StatelessWidget {
  const FLutterTube({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModularApp(
      module: AppModule(),
      child: AppWidget(),
    );
  }
}