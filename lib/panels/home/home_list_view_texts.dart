import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;

import 'four_divided_texts.dart';

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
          child: FourDividedTexts(
            height: height,
            texts: const [
              "Des notions complexes réalisées simplement",
              "Des idées novatrices",
              "Des pratiques exemplaires",
              "Des prix contenus"
            ],
          ),
        ),
        Expanded(
          child: FourDividedTexts(
            height: height,
            texts: const [
              "Maraîchage sur sol vivant\ntoto",
              "Des idées novatrices",
              "Des pratiques exemplaires",
              "Des prix contenus"
            ],
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
