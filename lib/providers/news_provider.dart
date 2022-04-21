import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

import 'ProviderWidgets/cached_firebase_image.dart';

class NewsProvider extends ChangeNotifier {
  late final List<CachedFirebaseImage> _images = [
    ...globals.newsList.map(
      (name) => CachedFirebaseImage(
        name: name.name,
        boxFit: BoxFit.cover,
        locationFunction: (name) => name.getNewsImage(),
      ),
    )
  ];

  int get nbNews => _images.length;
  CachedFirebaseImage newsImage(index) => _images[index];
}
