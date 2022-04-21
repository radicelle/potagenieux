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
            color: globals.headerTextColor,
            gap: 8,
            tabBorderRadius: 30,
            activeColor: globals.headerTextColor,
            tabBackgroundGradient: LinearGradient(colors: [
              globals.backgroundColor,
              globals.backgroundColor.withOpacity(0.5)
            ]),
            curve: Curves.easeInExpo, // tab animation curves
            duration: const Duration(milliseconds: 600),
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Accueil",
                onPressed: () => menuItemProvider.select(ShadingItem.home),
              ),
              GButton(
                icon: Icons.portrait,
                text: "Blog",
                onPressed: () => menuItemProvider.select(ShadingItem.blog),
              ),
              GButton(
                icon: Icons.fiber_new_sharp,
                text: "News",
                onPressed: () => menuItemProvider.select(ShadingItem.news),
              ),
              GButton(
                icon: Icons.shopping_basket,
                text: "Produits",
                onPressed: () => menuItemProvider.select(ShadingItem.products),
              ),
            ]),
      );
    });
  }
}
