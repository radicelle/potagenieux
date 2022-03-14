import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

class HomeListViewTexts extends StatelessWidget {
  const HomeListViewTexts({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "L'esprit de la ferme",
              style: globals.headerTextStyle(context),
            ),
          ),
        ),
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Des notions complexes réalisées simplement"
                            .toUpperCase(),
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
                        "Des idées novatrices".toUpperCase(),
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
                        "Des pratiques exemplaires".toUpperCase(),
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
                        "Des prix contenus".toUpperCase(),
                        style: globals.bodyTextStyle(context),
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: width,
          ),
        )
      ],
    );
  }
}
