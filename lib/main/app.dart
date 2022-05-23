import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../ui/theme/app_theme.dart';
import 'factories/factories.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  App({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return GetMaterialApp(
      title: 'Youtube Favoritos',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      navigatorKey: _navigatorKey,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('pt', 'BR'),
      ],
      fallbackLocale: const Locale('pt', 'BR'),
      getPages: [
        GetPage(
          name: '/home',
          page: makeHomePage,
          title: 'Inicio',
        ),
      ],
    );
  }
}
