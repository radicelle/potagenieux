import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

class FourDividedTexts extends StatelessWidget {
  const FourDividedTexts({Key? key, required this.height, required this.texts})
      : assert(texts.length == 4),
        super(key: key);

  final double height;
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
                  texts[0].toUpperCase(),
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
                  texts[1].toUpperCase(),
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
                  texts[2].toUpperCase(),
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
                  texts[3].toUpperCase(),
                  style: globals.bodyTextStyle(context),
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }
}
