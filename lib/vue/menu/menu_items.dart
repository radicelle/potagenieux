import 'package:flutter/cupertino.dart';
import 'package:potagenieux/providers/login_provider.dart';
import 'package:provider/provider.dart';

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
    return Consumer<LoginProvider>(builder: (context, loginProvider, _) {
      return Column(
        children: [
          MenuButton(
            height: panelHeight / 10,
            width: finalMenuWidth,
            text: "HOME",
          ),
          if (loginProvider.isConnected())
            MenuButton(
              height: panelHeight / 10,
              width: finalMenuWidth,
              text: "PRODUITS",
            ),
          if (loginProvider.isConnected())
            MenuButton(
              height: panelHeight / 10,
              text: "FORMATIONS",
              width: finalMenuWidth,
            ),
        ],
      );
    });
  }
}
