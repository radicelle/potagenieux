import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;

class HomeListViewTexts extends StatelessWidget {
  const HomeListViewTexts({
    Key? key,
    required this.start,
    required this.numberToDisplay,
    this.title = true,
  }) : super(key: key);

  final int start;
  final int numberToDisplay;
  final bool title;

  @override
  Widget build(BuildContext context) {
    var texts = [
      [
        "Des notions complexes réalisées simplement",
        "Maraîchage sur sol vivant\n\nAutomatisation\n\nBioclimatisme\n\nMicro-biologie"
      ],
      [
        "Des idées novatrices",
        "Maraîchage syntropique\n\nCompostage Johnson-Su\n\nThé de composte"
      ],
      [
        "Des pratiques exemplaires",
        "Maraîche bio\n\nTrès peu d'intrants\n\nPas de traitements"
      ],
      [
        "Des prix contenus",
        "Toutes ces pratiques garantissent un rendement idéal et des légumes en bonne santé qui restent abordables par leur positionnement adapté au marché"
      ]
    ].sublist(start, numberToDisplay + start);
    var boxHeight = MediaQuery.of(context).size.height;

    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.all(boxHeight / 20),
          child: Center(
            child: PlatformText(
              "L'esprit de la ferme",
              textAlign: TextAlign.center,
              style: globals.headerTextStyle(context),
            ),
          ),
        ),
        ...texts.map(
          (t) {
            var nbTextOnRow = 2;
            var boxWidth = MediaQuery.of(context).size.width / nbTextOnRow;
            var indent = boxWidth / 6;
            return SizedBox(
              width: boxWidth,
              height: boxHeight / (6 / nbTextOnRow),
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Text(
                            t[0],
                            style: globals.bodyTextStyle(context),
                            textAlign: TextAlign.center,
                          )),
                      Divider(
                        color: globals.headerTextColor,
                        thickness: 2,
                        indent: indent,
                        endIndent: indent,
                      ),
                      Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                t[1],
                                style: globals.bodyTextStyle(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
