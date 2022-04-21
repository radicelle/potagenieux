import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:potagenieux/providers/illuminable.dart';
import 'package:potagenieux/providers/menu_item_provider.dart';
import 'package:provider/provider.dart';

import 'globals.dart' as globals;

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuItemProvider>(builder: (context, menuItemProvider, __) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: GNav(
            rippleColor: globals.backgroundColor,
            tabActiveBorder:
                Border.all(color: globals.backgroundColor, width: 1),
            tabs: [
              GButton(
                icon: Icons.home,
                text: " Accueil",
                iconColor: globals.headerTextColor,
                textColor: globals.headerTextColor,
                iconActiveColor: globals.headerTextColor,
                onPressed: () => menuItemProvider.select(ShadingItem.home),
              ),
              GButton(
                icon: Icons.shopping_basket,
                text: " Produits",
                iconActiveColor: globals.headerTextColor,
                iconColor: globals.headerTextColor,
                textColor: globals.headerTextColor,
                onPressed: () => menuItemProvider.select(ShadingItem.products),
              ),
            ]),
      );
    });
  }
}
