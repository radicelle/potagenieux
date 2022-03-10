import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class ImagePanelChangeNotifier extends ChangeNotifier {
  late int _selectedIndex;
  late final List<Image> _images = [
    ...globals.imagesNamesMap.values.map((name) => Image.asset(
          name.getAsset(),
          fit: BoxFit.cover,
          key: ValueKey(name),
        ))
  ];
  final List<Image> _miniatures = [
    ...globals.imagesNamesMap.values.map((name) => Image.asset(
          name.getMiniAsset(),
          fit: BoxFit.fill,
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
