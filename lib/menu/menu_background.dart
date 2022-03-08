import 'package:flutter/cupertino.dart';

import '../globals.dart' as globals;

class MenuBackground extends StatelessWidget {
  const MenuBackground({
    Key? key,
    required this.finalMenuWidth,
    required this.panelHeight,
  }) : super(key: key);

  final double finalMenuWidth;
  final double panelHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(globals.menuBackgroundColor),
      width: finalMenuWidth,
      height: panelHeight,
    );
  }
}
