import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;

class GDPRProvider extends ChangeNotifier {
  GDPRProvider() {
    _cookiesConsent = CookiesConsent.none;
  }

  late CookiesConsent _cookiesConsent;

  set cookiesConsent(CookiesConsent consent) {
    _cookiesConsent = consent;
    notifyListeners();
  }

  void askForConsent(BuildContext context) {
    showPlatformDialog(
        context: context,
        builder: (context) {
          var width = MediaQuery.of(context).size.width;
          var height = MediaQuery.of(context).size.height;
          var portrait = height / width > 1;
          var topStart = 0.25 * height;
          var leftStart = (portrait ? 0.15 : 0.35) * width;
          var modalStackWidth = portrait ? width * 0.7 : width * 0.3;
          var modalStackHeight = height * 0.5;
          const double closeIconSize = 12;
          var modalTextPadding = modalStackWidth / 20;

          return Material(
            child: MaterialApp(
              theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity),
              builder: (context, _) {
                var buttonWidth = modalStackWidth / (portrait ? 3 : 4.5);
                var buttonHeight = modalStackHeight / 13;
                var acceptBtnBottomPos = topStart + modalTextPadding / 2;
                var acceptBtnLeftPos = leftStart + modalTextPadding;
                return Stack(
                  children: [
                    Positioned(
                      top: topStart,
                      left: leftStart,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: CupertinoColors.white,
                          width: modalStackWidth,
                          height: modalStackHeight,
                        ),
                      ),
                    ),
                    Positioned(
                      top: topStart,
                      left: leftStart,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: modalTextPadding, top: 8),
                        child: Text(
                          "Paramètres des cookies",
                          style: globals.modalHeaderTextStyle(context),
                        ),
                      ),
                    ),
                    Positioned(
                      top: topStart,
                      left: leftStart +
                          modalStackWidth -
                          closeIconSize -
                          modalStackWidth * 0.045,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: closeIconSize,
                        ),
                        splashRadius: 1,
                      ),
                    ),
                    Positioned(
                      top: topStart + buttonHeight,
                      left: leftStart,
                      width: modalStackWidth,
                      child: SizedBox(
                        height: modalStackHeight / 1.3,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(modalTextPadding),
                            child: SingleChildScrollView(
                              child: Text(
                                _text,
                                style: globals.modalBodyTextStyle(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: acceptBtnBottomPos,
                      left: acceptBtnLeftPos,
                      child: PlatformElevatedButton(
                        onPressed: () {
                          cookiesConsent = CookiesConsent.all;
                          Navigator.of(context).pop();
                        },
                        child: const Text("Accepter tout"),
                      ),
                    ),
                    Positioned(
                      bottom: acceptBtnBottomPos,
                      left: acceptBtnLeftPos + buttonWidth + 10,
                      child: PlatformElevatedButton(
                        onPressed: () {
                          cookiesConsent = CookiesConsent.none;
                          Navigator.of(context).pop();
                        },
                        child: const Text("Refuser tout"),
                        material: (_, __) => MaterialElevatedButtonData(
                            style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(color: Colors.white)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF8FB8D6)))),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  static const String _text =
      "Lorsque vous visitez l'un de nos sites Web, il peut stocker ou récupérer des informations sur votre navigateur, principalement sous la forme de cookies. Ces informations peuvent vous concerner, vos préférences ou votre appareil et sont principalement utilisées pour faire fonctionner le site comme vous l'attendez. Les informations ne vous identifient généralement pas directement, mais elles peuvent vous offrir une expérience Web plus personnalisée. Parce que nous respectons votre droit à la vie privée, vous pouvez choisir de ne pas autoriser certains types de cookies. Cliquez sur les différentes rubriques des catégories pour en savoir plus et gérer vos préférences. Veuillez noter que le blocage de certains types de cookies peut avoir un impact sur votre expérience du site et les services que nous sommes en mesure d'offrir.";
}

enum CookiesConsent { all, none }
