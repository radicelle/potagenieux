import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

import '../../providers/illuminable.dart';
import '../../providers/menu_item_provider.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.item,
    required this.menuItemProvider,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final ShadingItem item;
  final MenuItemProvider menuItemProvider;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => menuItemProvider.select(item),
      child: MouseRegion(
        onEnter: (e) => menuItemProvider.illuminate(e, item),
        onExit: (e) => menuItemProvider.shade(e, item),
        child: Opacity(
          opacity: menuItemProvider.opacity(item),
          child: Row(
            children: [
              if (menuItemProvider.selectedItem == item)
                Icon(
                  Icons.arrow_right,
                  color: globals.menuColor,
                ),
              Text(
                text,
                style: globals.menuTextStyle(context),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(icon, color: globals.menuColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
