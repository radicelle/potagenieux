library potagenieux.globals;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

extension GlobalStringExtensions on String {
  String getAsset() => 'assets/$this';
  String getAssetImage() => 'assets/images/$this.jpg';
  String getAssetMiniImage() => 'assets/images/${this}_mini.jpg';
  String getProductImage() => 'products/${this}';
  String getNewsImage() => 'news/${this}';
  String getBlogImage() => 'blog/${this}';
}

const defaultOpacity = 0.7;
const menuBackgroundColor = 0xff9AA644;
const appBarHeight = 30.0;
const largeMobile = "LARGE_MOBILE";
const smallDesktop = "SMALL_DESKTOR";

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

const backgroundColorNumber = 0xFF007878;
const backgroundColor = Color(0xFF007878);
final materialMenuBackgroundColor = MaterialColor(
    backgroundColorNumber, menuBackgroundColorMap); // opposite : 0xFFF05900
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

modalHeaderTextStyle(context) {
  return GoogleFonts.roboto(
    textStyle: Theme.of(context).textTheme.headline5,
    color: Colors.black,
  );
}

modalBodyTextStyle(context) {
  return GoogleFonts.roboto(
    textStyle: Theme.of(context).textTheme.bodyMedium,
    color: Colors.black,
  );
}

final headerTextColor = Colors.white.withOpacity(0.6);
final menuColor = Colors.white.withOpacity(0.7);

headerTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline4, color: headerTextColor);
}

newsHeaderTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline6, color: headerTextColor);
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

const productsList = [
  Product("batavia.jpg", "Salade batavia", true),
  Product("epinard.jpg", "Epinards", true),
  Product("harictos.jpg", "Haricots verts", false),
  Product("mesclunCretois.jpeg", "Mesclun cretois", true),
  Product("poireaux.jpg", "Poireaux d'hiver", true),
  Product("tomate.jpg", "Tomates coeur de boeuf", false),
  Product("tomateCerises.png", "Tomates cerises", false)
];
List<News> newsList = [
  News(
      "tomateCerises.png",
      "Cette année la météo est clémente pour les tomates, on les attend avec impatience.",
      DateTime(2022, 04, 21)),
  News(
      "bioreacteur.jpg",
      "Et voilà le premier bioreacteur Johson-Su est prêt à être chargé. Les merveilles du compostage à découvrir dans l'onglet \"Blog\" du site.",
      DateTime(2022, 04, 22)),
  News(
      "harictos.jpg",
      "Les haricots c'est pour bientôt ! La production est en court, ils seront en stock d'ici un mois alors, soyez prêts.",
      DateTime(2022, 04, 18)),
];

class Product {
  const Product(this.name, this.desc, this.inStock);
  final String name;
  final String desc;
  final bool inStock;
}

class News {
  const News(this.name, this.desc, this.date);
  final String name;
  final String desc;
  final DateTime date;
}

void showErrorDialog(BuildContext context, String title, Exception e) {
  showPlatformDialog<void>(
    context: context,
    builder: (context) {
      return PlatformAlertDialog(
        title: PlatformText(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              PlatformText(
                '${(e as dynamic).message}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          PlatformTextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: PlatformText(
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

bool displayMenu(BuildContext c) {
  return ResponsiveWrapper.of(c).isLargerThan(largeMobile);
}

bool displayDrawer(BuildContext c) {
  return !ResponsiveWrapper.of(c).isLargerThan(largeMobile);
}
