library potagenieux.globals;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension GlobalStringExtensions on String {
  String getAsset() => 'assets/images/$this.jpg';
  String getMiniAsset() => 'assets/images/${this}_mini.jpg';
}

const defaultOpacity = 0.7;
const menuBackgroundColor = 0xff9AA644;
const appBarHeight = 30.0;

Map<int, Color> menuBackgroundColorMap = {
  50: const Color.fromRGBO(0, 120, 120, .1),
  100: const Color.fromRGBO(0, 120, 120, .2),
  200: const Color.fromRGBO(0, 120, 120, .3),
  300: const Color.fromRGBO(0, 120, 120, .4),
  400: const Color.fromRGBO(0, 120, 120, .5),
  500: const Color.fromRGBO(0, 120, 120, .6),
  600: const Color.fromRGBO(0, 120, 120, .7),
  700: const Color.fromRGBO(0, 120, 120, .8),
  800: const Color.fromRGBO(0, 120, 120, .9),
  900: const Color.fromRGBO(0, 120, 120, 1),
};

final materialMenuBackgroundColor =
    MaterialColor(0xFF007878, menuBackgroundColorMap); // opposite : 0xFFF05900
bodyTextTheme(context) {
  return GoogleFonts.aBeeZeeTextTheme(
    Theme.of(context).textTheme,
  );
}

bodyTextStyle(context) {
  return GoogleFonts.aBeeZee(
    textStyle: Theme.of(context).textTheme.bodyMedium,
    color: headerTextColor,
  );
}

final headerTextColor = Colors.white.withOpacity(0.6);
final menuColor = Colors.white.withOpacity(0.7);

headerTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline4, color: headerTextColor);
}

loginTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline6, color: headerTextColor);
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

void showErrorDialog(BuildContext context, String title, Exception e) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                '${(e as dynamic).message}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ],
      );
    },
  );
}

enum CloudFunctions { sendMail }

String? emailValidator(String? value) {
  if (EmailValidator.validate(value ?? "")) {
    return null;
  } else {
    return "Saisissez un email valide";
  }
}

String? notEmptyValidator(String? value) {
  if (value?.isNotEmpty == true) {
    return null;
  } else {
    return "Saississez quelque chose";
  }
}
