import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

import 'ProviderWidgets/cached_firebase_image.dart';

class ArticleProvider extends ChangeNotifier {
  late final List<CachedFirebaseImage> _images = [
    ...globals.blogList.map(
      (name) => CachedFirebaseImage(
        name: name.name,
        boxFit: BoxFit.cover,
        locationFunction: (name) => name.getArticleImage(),
      ),
    )
  ];

  int get nbArticles => _images.length;
  CachedFirebaseImage articleImage(index) => _images[index];
}
