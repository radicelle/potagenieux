import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;

import 'four_divided_texts.dart';

class HomeListViewTexts extends StatelessWidget {
  const HomeListViewTexts({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: PlatformText(
              "L'esprit de la ferme",
              style: globals.headerTextStyle(context),
            ),
          ),
        ),
        Expanded(
          child: FourDividedTexts(
            height: height,
            uppercase: true,
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
              "Maraîchage sur sol vivant\n\nAutomatisation\n\nBioclimatisme\n\nMicro-biologie",
              "Maraîchage syntropique\n\nCompostage Johnson-Su\n\nThé de composte",
              "Maraîche bio\n\nTrès peu d'intrants\n\nPas de traitements",
              "Toutes ces pratiques garantissent un rendement idéal et des légumes en bonne santé qui restent abordables par leur positionnement adapté au marché"
            ],
          ),
        ),
        Expanded(
          child: Container(),
        )
      ],
    );
  }
}
