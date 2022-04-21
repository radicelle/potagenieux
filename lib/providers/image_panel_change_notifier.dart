import 'package:flutter/material.dart';
import 'package:potagenieux/providers/ProviderWidgets/cached_firebase_image.dart';

import '../globals.dart' as globals;

class ImagePanelChangeNotifier extends ChangeNotifier {
  late int _selectedIndex;

  late final List<CachedFirebaseImage> _images = [
    ...globals.imagesNamesMap.values.map(
      (name) => CachedFirebaseImage(
        name: name,
        boxFit: BoxFit.cover,
        locationFunction: (name) => name.getAssetImage(),
      ),
    )
  ];
  final List<CachedFirebaseImage> _miniatures = [
    ...globals.imagesNamesMap.values.map((name) => CachedFirebaseImage(
          name: name,
          boxFit: BoxFit.fill,
          locationFunction: (name) => name.getAssetMiniImage(),
          height: 70,
        ))
  ];

  ImagePanelChangeNotifier.fromIndex(int index) {
    _selectedIndex = index;
  }
  Widget get selectedImage => _images[_selectedIndex];
  int get selected => _selectedIndex;

  set selectedIndex(int index) {
    if (index == _selectedIndex) return;
    _selectedIndex = index;
    notifyListeners();
  }

  miniature(int index) => _miniatures[index];
}
