import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

import 'ProviderWidgets/cached_firebase_image.dart';

class ArticleProvider extends ChangeNotifier {
  late final Map<String, CachedFirebaseImage> _images = {
    for (var article in globals.blogList)
      article.name: CachedFirebaseImage(
        name: article.name,
        boxFit: BoxFit.cover,
        locationFunction: (name) => name.getArticleImage(),
      )
  };

  int get nbArticles => _images.length;
  CachedFirebaseImage articleImage(name) => _images[name]!;
}
