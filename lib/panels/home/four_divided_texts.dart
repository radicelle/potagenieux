import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

class FourDividedTexts extends StatelessWidget {
  const FourDividedTexts(
      {Key? key,
      this.uppercase = false,
      required this.height,
      required this.texts})
      : assert(texts.length == 4),
        super(key: key);

  final double height;
  final bool uppercase;
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  uppercase ? texts[0].toUpperCase() : texts[0],
                  style: globals.bodyTextStyle(context),
                  textAlign: TextAlign.center,
                )),
          ),
          VerticalDivider(
            indent: height / 10,
            endIndent: height / 10,
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  uppercase ? texts[1].toUpperCase() : texts[1],
                  style: globals.bodyTextStyle(context),
                  textAlign: TextAlign.center,
                )),
          ),
          VerticalDivider(
            indent: height / 10,
            endIndent: height / 10,
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  uppercase ? texts[2].toUpperCase() : texts[2],
                  style: globals.bodyTextStyle(context),
                  textAlign: TextAlign.center,
                )),
          ),
          VerticalDivider(
            indent: height / 10,
            endIndent: height / 10,
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  uppercase ? texts[3].toUpperCase() : texts[3],
                  style: globals.bodyTextStyle(context),
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }
}
