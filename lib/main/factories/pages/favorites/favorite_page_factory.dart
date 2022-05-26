import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import 'favorites.dart';

Widget makeFavoritePage() => FavoritesPage(presenter: makeGetxFavoritePresenter());
