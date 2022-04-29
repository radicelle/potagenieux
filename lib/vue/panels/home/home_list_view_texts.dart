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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Wrap(
            alignment: WrapAlignment.center,
            children: [
              Center(
                child: PlatformText(
                  "L'esprit de la ferme",
                  textAlign: TextAlign.center,
                  style: globals.headerTextStyle(context),
                ),
              ),
              Divider(
                height: constraints.maxHeight / 10,
                thickness: 2,
                color: globals.headerTextColor,
                indent: constraints.maxWidth / 10,
                endIndent: constraints.maxWidth / 10,
              ),
              ...texts.map(
                (t) {
                  var textsByRow = 2;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.6 /
                        (4 / textsByRow),
                    width: constraints.maxWidth / textsByRow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          indent: constraints.maxWidth / 10,
                          endIndent: constraints.maxWidth / 10,
                        ),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                t[1],
                                style: globals.bodyTextStyle(context),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
