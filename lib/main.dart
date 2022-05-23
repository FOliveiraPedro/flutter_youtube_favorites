import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'pt_BR';

  runApp(App());
}
