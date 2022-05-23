import 'dart:ui';

import 'strings/strings.dart';

mixin R {
  static PtBr strings = PtBr();

  static void load(final Locale locale) {
    switch (locale.toString()) {
      default:
        strings = PtBr();
        break;
    }
  }
}
