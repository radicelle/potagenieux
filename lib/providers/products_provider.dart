import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

import 'ProviderWidgets/cached_firebase_image.dart';

class ProductsProvider extends ChangeNotifier {
  late final List<CachedFirebaseImage> _images = [
    ...globals.productsList.map(
      (name) => CachedFirebaseImage(
        name: name.name,
        boxFit: BoxFit.cover,
        locationFunction: (name) => name.getProductImage(),
      ),
    )
  ];

  int get nbProducts => _images.length;
  CachedFirebaseImage productImage(index) => _images[index];
}
