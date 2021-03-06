import 'package:flutter/material.dart';
import 'package:potagenieux/providers/illuminable.dart';
import 'package:potagenieux/providers/menu_item_provider.dart';
import 'package:potagenieux/vue/menu/login/fire_login.dart';
import 'package:potagenieux/vue/menu/menu_info.dart';
import 'package:potagenieux/vue/menu/menu_section_item.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key? key,
    required this.itemsProvider,
  }) : super(key: key);
  final MenuItemProvider itemsProvider;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight / 3,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FireLogin(),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight / 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MenuSectionItem(
                      item: ShadingItem.home,
                      menuItemProvider: itemsProvider,
                      text: "Accueil",
                      icon: Icons.home,
                    ),
                    MenuSectionItem(
                      item: ShadingItem.blog,
                      menuItemProvider: itemsProvider,
                      text: "Blog",
                      icon: Icons.portrait,
                    ),
                    MenuSectionItem(
                      item: ShadingItem.news,
                      menuItemProvider: itemsProvider,
                      text: "News",
                      icon: Icons.fiber_new_sharp,
                    ),
                    MenuSectionItem(
                      item: ShadingItem.products,
                      menuItemProvider: itemsProvider,
                      text: "Produits",
                      icon: Icons.shopping_basket,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight / 3,
              child: const MenuInfo(),
            )
          ],
        );
      },
    );
  }
}
