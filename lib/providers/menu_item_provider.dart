import 'package:flutter/material.dart';
import 'package:potagenieux/providers/illuminable.dart';

class MenuItemProvider extends Illuminable {
  late ShadingItem selectedItem;
  static const Map<ShadingItem, MenuItemObject> items = {
    ShadingItem.home:
        MenuItemObject(iconData: Icons.home, text: "Accueil", index: 0),
    ShadingItem.blog:
        MenuItemObject(iconData: Icons.portrait, text: "Blog", index: 1),
    ShadingItem.news:
        MenuItemObject(iconData: Icons.fiber_new_sharp, text: "News", index: 2),
    ShadingItem.products: MenuItemObject(
        iconData: Icons.shopping_basket, text: "Produits", index: 3),
  };

  currentIndex() => items[selectedItem]?.index;

  MenuItemProvider() {
    selectedItem = ShadingItem.home;
  }
  select(ShadingItem item) {
    selectedItem = item;
    notifyListeners();
  }
}

class MenuItemObject {
  const MenuItemObject(
      {required this.iconData, required this.index, required this.text});
  final IconData iconData;
  final int index;
  final String text;
}
