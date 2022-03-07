library potagenieux.globals;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'hover_selectable_image.dart';

extension GlobalStringExtensions on String {
  String getAsset() => 'images/MSV/$this.jpg';
}

const defaultOpacity = 0.7;

final headerColor = Colors.white.withOpacity(0.6);
final menuColor = Colors.white.withOpacity(0.7);

headerTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline4, color: headerColor);
}

menuTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline5, color: menuColor);
}

const imagesNamesMap = {
  0: "MSV1",
  1: "MSV2",
  2: "MSV3",
  3: "MSV4",
  4: "MSV5",
  5: "MSV6",
  6: "MSV7",
  7: "MSV8"
};

final miniImages = [
  ...imagesNamesMap.keys.map((imageIndex) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: HoverSelectableImage(imageIndex),
      ))
];
