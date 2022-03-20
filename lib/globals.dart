library potagenieux.globals;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension GlobalStringExtensions on String {
  String getAsset() => 'assets/$this';
  String getAssetImage() => 'assets/images/$this.jpg';
  String getAssetMiniImage() => 'assets/images/${this}_mini.jpg';
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

main() {
  String s = """# MENTIONS LÉGALES

Conformément aux dispositions des Articles 6-III et 19 de la Loi n°2004-575 du 21 juin 2004 pour la Confiance dans l’économie numérique, dite L.C.E.N., il est porté à la connaissance des Utilisateurs du site https://potagenieux.fr les présentes mentions légales.
La connexion et la navigation sur le site https://potagenieux.fr par l’Utilisateur implique acceptation intégrale et sans réserve des présentes mentions légales.
Ces dernières sont accessibles sur le site à la rubrique « Mentions légales ».

## Article 1 – informations légales.

Le site potagenieux.fr est édité par :

**Emmanuel Breton-Belz – Radicelle**

**2, impasse des Roquerets**

**14500 VIRE NORMANDIE**

- SIRET : 89178562800019
- Téléphone : 0679122243

Adresse e-mail : emmanuelbretonbelz@gmail.fr

- Conception et réalisation : Radicelle

Le Directeur de publication est : Emmanuel Breton-Belz

- contact : emmanuelbretonbelz@gmail.fr

Le site est hébergé par :
Firebase, 188 King ST, San Francisco, CA 94107, United States, https://firebase.google.com/

Le site https://potagenieux.fr est régulièrement mis à jour. Il en est de même pour les mentions légales qui peuvent être modifiées à tout moment. Il appartient à l’utilisateur de les consulter.

## Article 2 – Services fournis.
Le site https://potagenieux.fr fournit des informations relatives aux activités de la société.
Radicelle fournit des informations les plus précises possible. Les informations présentes sur https://potagenieux.fr sont données à titre indicatifs et peuvent être modifiées à tout moment.

## Article 3 – accessibilité.
Le site est par principe accessible aux utilisateurs 24/24h et 7/7j, sauf interruption, programmée ou non, pour des besoins de maintenance ou en cas de force majeure. En cas d’impossibilité d’accès au Site, celui-ci s’engage à faire son maximum afin d’en rétablir l’accès. Le Site ne saurait être tenu pour responsable de tout dommage, quelle qu’en soit la nature, résultant de son indisponibilité.


## Article 4 – Limitations contractuelles sur les données techniques.
Le site utilise les technologies javascript, html, css, nodeJs, Firebase et le framework Flutter.
Le site https://potagenieux.fr  ne sera pas retenu responsable d’éventuels dommages relatifs à l’utilisation du site. Il appartient à l’utilisateur de faire usage de matériels récents, sans virus, avec un navigateur actuel et mis a jour.

## Article 5 – Collecte des données.
Le site assure à l’utilisateur une collecte et un traitement d’informations personnelles dans le respect de la vie privée conformément à la loi n°78-17 du 6 janvier 1978 relative à l’informatique, aux fichiers et aux libertés.
En vertu de la loi Informatique et Libertés, en date du 6 janvier 1978, l’utilisateur dispose d’un droit d’accès, de rectification, de suppression et d’opposition de ses données personnelles.
L’Utilisateur exerce ce droit :
- par mail à l’adresse mail emmanuelbretonbelz@gmail.fr
- via un formulaire de contact

## Article 6 – propriété intellectuelle.
Radicelle est propriétaire ou détient les droits d’usage de propriété intellectuelle de tous les éléments présent sur le site (images, photos, logo, graphisme, icones, textes, logiciels, sons…).
Toute reproduction, représentation, modification, publication, adaptation de tout ou partie des éléments du site sans autorisation préalable est strictement interdite.
L’exploitation du site ou d’un des éléments constitutifs du site sans autorisation fera l’objet de poursuite pour contrefaçon, conformément aux dispositions des articles L.335-2 et suivants du Code de Propriété Intellectuelle.
Pour plus d’informations, se reporter aux CGU du site https://potagenieux.fr accessible à la rubrique« CGU ».

## Article 7 – politique de cookies et liens hypertextes.
Le site https://potagenieux.fr a éventuellement recours aux techniques de « cookies » lui permettant de traiter des statistiques et des informations sur le trafic, de faciliter la navigation et d’améliorer le service pour le confort de l’utilisateur.
Conformément à la législation européenne, le site Radicelle.fr a mis à jour sa politique de confidentialité en matière de cookies. L’utilisateur est libre d’accepter ou de refuser les cookies de tous les sites internet en modifiant les paramètres de son navigateur internet.

Le site https://potagenieux.fr contient quelques liens hypertextes vers d’autres sites. Néanmoins, Radicelle n’a pas la possibilité d’en vérifier le contenu et, par conséquence, ne pourra pas en être tenu pour responsable.

## Article 8 – loi applicable et juridiction
Tout litige en relation avec l’utilisation du site https://potagenieux.fr est soumis au droit français. Il est fait attribution exclusive de juridiction aux tribunaux compétents de paris.
> Loi n° 78-87 et Loi 78-17 du 6 janvier 1978, notamment modifiée par la loi n° 2004-801 du 6 août 2004 relative à l’informatique, aux fichiers et aux libertés.

>Loi n° 2004-575 du 21 juin 2004 pour la confiance dans l’économie numérique.

>Loi du 1er juillet 1998 transposant la directive 96/9 du 11 mars 1996 relative à la protection juridique des bases de données.

## Article 9 – contact
Pour tout signalement de contenus ou d’activités illicites, l’utilisateur peut contacter l’Éditeur à l’adresse suivante : emmanuelbretonbelz@gmail.fr, ou par courrier recommandé avec accusé de réception adressé à l’Éditeur aux coordonnées précisées dans les présentes mentions légales.

## Article 10 – lexique.
Utilisateur : Sont considérés comme utilisateurs tous les internautes qui naviguent, lisent, visionnent et utilisent le site https://potagenieux.fr.
Informations personnelles : « les informations qui permettent, sous quelque forme que ce soit, directement ou non, l’identification des personnes physiques auxquelles elles s’appliquent » (article 4 de la loi n° 78-17 du 6 janvier 1978).
""";
}
