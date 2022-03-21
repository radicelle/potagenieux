import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

class MenuText extends StatelessWidget {
  const MenuText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: globals.headerTextColor),
    );
  }
}
