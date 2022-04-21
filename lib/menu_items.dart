import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/products_list_view.dart';
import 'package:potagenieux/providers/gdpr_provider.dart';
import 'package:potagenieux/providers/illuminable.dart';
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:potagenieux/providers/login_provider.dart';
import 'package:potagenieux/providers/menu_item_provider.dart';
import 'package:potagenieux/providers/products_provider.dart';
import 'package:potagenieux/vue/menu/login/fire_loggin.dart';
import 'package:potagenieux/vue/menu/menu_item.dart';
import 'package:potagenieux/vue/panels/home/home_list_view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'firebase_options.dart';
import 'globals.dart' as globals;

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
              height: constraints.maxHeight / 4,
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
                    MenuItem(
                      item: ShadingItem.home,
                      menuItemProvider: itemsProvider,
                      text: "Home",
                      icon: Icons.home,
                    ),
                    MenuItem(
                      item: ShadingItem.products,
                      menuItemProvider: itemsProvider,
                      text: "Products",
                      icon: Icons.shopping_basket,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
