import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

class DividedTexts extends StatelessWidget {
  const DividedTexts(
      {Key? key,
      this.uppercase = false,
      required this.height,
      required this.texts})
      : super(key: key);

  final double height;
  final bool uppercase;
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...texts.map(
            (text) => Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  uppercase ? text.toUpperCase() : text,
                  style: globals.bodyTextStyle(context),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          VerticalDivider(
            indent: height / 10,
            endIndent: height / 10,
          ),
          VerticalDivider(
            indent: height / 10,
            endIndent: height / 10,
          )
        ],
      ),
    );
  }
}
