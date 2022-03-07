import 'package:flutter/material.dart';

import 'globals.dart' as globals;

class MainImageChangeNotifier extends ChangeNotifier {
  late Widget _image;
  late int _selectedIndex;

  MainImageChangeNotifier.fromIndex(int index) {
    _image = globals.miniImages[index];
    _selectedIndex = index;
  }
  Widget get image => _image;
  int get selected => _selectedIndex;

  setImage(int index) {
    if (index == _selectedIndex) return;
    _image = globals.miniImages[index];
    _selectedIndex = index;
    notifyListeners();
  }
}
