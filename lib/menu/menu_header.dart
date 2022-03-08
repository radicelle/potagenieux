import 'package:flutter/cupertino.dart';

import '../globals.dart' as globals;

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    Key? key,
    required this.menuWidth,
    required this.panelHeight,
    required this.rightContainerHeight,
  }) : super(key: key);

  final double menuWidth;
  final double panelHeight;
  final double rightContainerHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: menuWidth,
      height: panelHeight - rightContainerHeight,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "Potagenieux",
          style: globals.headerTextStyle(context),
        ),
      ),
    );
  }
}
