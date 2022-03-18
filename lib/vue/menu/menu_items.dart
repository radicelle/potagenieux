import 'package:flutter/cupertino.dart';

import 'menu_button.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key? key,
    required this.panelHeight,
    required this.finalMenuWidth,
  }) : super(key: key);

  final double panelHeight;
  final double finalMenuWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuButton(
          height: panelHeight / 10,
          width: finalMenuWidth,
          text: "HOME",
        ),
        MenuButton(
          height: panelHeight / 10,
          width: finalMenuWidth,
          text: "PRODUITS",
        ),
        MenuButton(
          height: panelHeight / 10,
          text: "FORMATIONS",
          width: finalMenuWidth,
        ),
        MenuButton(
          height: panelHeight / 10,
          text: "CONTACT",
          width: finalMenuWidth,
        ),
      ],
    );
  }
}
