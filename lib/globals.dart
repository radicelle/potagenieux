library potagenieux.globals;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension GlobalStringExtensions on String {
  String getAsset() => 'assets/images/$this.jpg';
  String getMiniAsset() => 'assets/images/${this}_mini.jpg';
}

const defaultOpacity = 0.7;
const menuBackgroundColor = 0xff9AA644;

final headerColor = Colors.white.withOpacity(0.6);
final menuColor = Colors.white.withOpacity(0.7);

headerTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline4, color: headerColor);
}

loginTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.bodyLarge, color: headerColor);
}

menuTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline5, color: menuColor);
}

const imagesNamesMap = {
  1: "MSV2",
  2: "MSV3",
  3: "MSV4",
  4: "MSV5",
  5: "MSV6",
  6: "MSV7",
  7: "MSV8",
  0: "MSV9",
};
