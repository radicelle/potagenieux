import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:potagenieux/providers/menu_item_provider.dart';
import 'package:provider/provider.dart';

import 'globals.dart' as globals;

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuItemProvider>(
      builder: (context, menuItemProvider, __) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GNav(
            selectedIndex: menuItemProvider.currentIndex(),
            color: globals.headerTextColor,
            gap: 8,
            tabBorderRadius: 30,
            activeColor: globals.headerTextColor,
            tabBackgroundGradient: LinearGradient(colors: [
              globals.backgroundColor,
              globals.backgroundColor.withOpacity(0.5)
            ]),
            curve: Curves.easeInExpo,
            // tab animation curves
            duration: const Duration(milliseconds: 600),
            tabs: [
              ...MenuItemProvider.items.entries.map((i) => GButton(
                    icon: i.value.iconData,
                    onPressed: () => menuItemProvider.select(i.key),
                    text: i.value.text,
                  ))
            ],
          ),
        );
      },
    );
  }
}
