import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

/// Interface dedicated to illuminated widgets
/// Use a map of Opacities to define your state and passe the item in the UI event to trigger this functions

class Illuminable extends ChangeNotifier {
  Illuminable();
  late final Map<ShadingItem, double> _opacities = {
    for (var i in ShadingItem.values) i: globals.defaultOpacity
  };

  double opacity(ShadingItem item) => _opacities[item]!;
  void illuminate(event, ShadingItem? shadingItem) {
    _opacities[shadingItem!] = 1;
    notifyListeners();
  }

  void shade(event, ShadingItem? shadingItem) {
    _opacities[shadingItem!] = globals.defaultOpacity;
    notifyListeners();
  }
}

enum ShadingItem { home, products, blog, news, connection, connect }
