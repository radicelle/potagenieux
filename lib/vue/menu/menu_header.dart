import 'package:flutter/cupertino.dart';

import '../../globals.dart' as globals;

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    Key? key,
    required this.width,
    required this.height,
    required this.rightContainerHeight,
  }) : super(key: key);

  final double width;
  final double height;
  final double rightContainerHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
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
