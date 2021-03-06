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
  String getArticleImage() => 'blog/${this}';
}

extension GlobalTableExtensions on Iterable {
  List<T> flatten<T>() => [for (var sublist in this) ...sublist];

  List<T> flattenDeep<T>() => [
        for (var element in this)
          if (element is! Iterable) element else ...element.flattenDeep(),
      ];
}

const defaultOpacity = 0.7;
const menuBackgroundHexa = 0xff9AA644;
const menuBackgroundColor = Color(0xff9AA644);
const appBarHeight = 30.0;
const largeMobile = "LARGE_MOBILE";
const smallDesktop = "SMALL_DESKTOR";
const productFormRoute = '/addProductForm';

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

const headerTextColor = Colors.white60;
const menuColor = Colors.white70;

headerTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline4, color: headerTextColor);
}

productHeaderTextStyle(context) {
  return GoogleFonts.aBeeZee(
      textStyle: Theme.of(context).textTheme.headline6, color: Colors.black);
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
      "Cette ann??e la m??t??o est cl??mente pour les tomates, on les attend avec impatience.",
      DateTime(2022, 04, 21)),
  News(
      "bioreacteur.jpg",
      "Et voil?? le premier bioreacteur Johson-Su est pr??t ?? ??tre charg??. Les merveilles du compostage ?? d??couvrir dans l'onglet \"Blog\" du site.",
      DateTime(2022, 04, 22)),
  News(
      "harictos.jpg",
      "Les haricots c'est pour bient??t ! La production est en court, ils seront en stock d'ici un mois alors, soyez pr??ts.",
      DateTime(2022, 04, 18)),
];

List<Article> blogList = [
  Article(
      "bioclimatic.jpg",
      "L'effet bioclimatique",
      "Tirer profit de l'??nergie solaire est essentiel pour r??duire notre d??pendance aux ??nergies fossile. Depuis bien longtemps l'homme connais divers techniques qui permettent de concenter et homog??n??iser cette ??nergie. L'effet bioclimatique en fait partie.\nEn effet avec un mat??riaux transparant et isolant au sud et un isolant ??pais face nord ainsi qu'une conduction de l'air on obtient un habitat qui se r??chauffe rapidement. Aussi l'a??ration abaisse la temp??rature quand il fait trop chaud.",
      DateTime(2022, 04, 01)),
  Article(
      "bioreacteur.jpg",
      "Le bio r??acteur Johnson-Su",
      "Les docteurs Johnson et Su sont un couple de scientifiques am??ricains s'appuyants sur les recherches de Elaine Ingham. Elle aussi scientifique de renom dans le milieu de la cha??ne alimentaire du sol. Gr??ce ?? des ann??es de recherches ils ont mis au point un composteur tr??s efficace et qui favorise la pr??sence de champignon gr??ce a des flux d'air qui oxyg??ne l'int??rieur du composteur. Un proc??d?? certe long, mais naturel et qui produit un engrai de choix pour fertiliser les sol et les semis.",
      DateTime(2022, 04, 6)),
  Article(
      "carbon-sol.png",
      "Capacit?? de r??tention du carbon dans le sol",
      "La s??questration du carbon dans le sol se fait de 3 mani??res. Les plantes produisent des exsudats racinaire sous forme de sucre. C'est la s??questration la plus rapide mais elle est limit?? ?? une ann??e. Ensuite il y a l'humus, ce sont des acides qui sont contenus dans la partie sup??rieure du sol. Cette fois la dur??e de stockage est beaucoup plus longue donc augmenter le stock d'humus augmente r??guli??rement le stockage de carbon. Enfin il y a toutes les parties a??riennes. C'est pour cela que passer d'une prairie ?? une for??t est int??ressant en terme de s??questration de carbone.",
      DateTime(2022, 04, 10)),
  Article(
      "climate-change.jpg",
      "L'effet de serre",
      "L'effet de serre dont nous parlons aujourd'hui a ??t?? mis en ??vidence par des scientifiques ?? la moiti?? du 19??me si??cle, mais ce n'est que beaucoup plus tard que des probl??mes de changement climatique sont arriv??s. L'effet de serre est due ?? la r??percussion des rayons solaire aux sein de l'atmoshp??re ce qui a pour effet de r??chauffer la plan??te. Bien entendu il existe des solution, comme consommer moins d'??nergie fossiles ou changer les pratiques agricoles pour stocker plus de carbon.",
      DateTime(2022, 04, 18)),
  Article(
      "syntropic.jpg",
      "L'argriculture syntropique",
      "L'agriculture syntropique est une partique agricole qui nous vient du Br??sil. Elle permet de profiter de la diff??rence de hauteur de chaque plante pour optimiser la production. Sous nos latitude, certains appelerons plut??t cela, de l'agroforesterie. Encore peut r??pondu, ce mod??le agricole ?? d??j?? quelques adeptes concquis en Europe et ne manque pas de points fort pour s??duire.",
      DateTime(2022, 04, 22)),
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

class Article {
  const Article(this.name, this.title, this.desc, this.date);
  final String name;
  final String title;
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
              style: const TextStyle(color: Colors.deepPurple),
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
