import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:provider/provider.dart';

import '../../../providers/login_provider.dart';
import '../../menu/login/disconnection_button.dart';
import '../../menu/login/unknown_account_login_form.dart';
import 'connection_button.dart';
import 'email_text_field.dart';
import 'known_account_login_form.dart';

class FireLogin extends StatefulWidget {
  const FireLogin({Key? key}) : super(key: key);

  @override
  _FireLoginState createState() => _FireLoginState();
}

class _FireLoginState extends State<FireLogin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (_, loginProvider, __) {
      return LayoutBuilder(builder: (context, constraints) {
        return MouseRegion(
          onEnter: (event) => loginProvider.illuminate(event, Item.connection),
          onExit: (event) => loginProvider.shade(event, Item.connection),
          child: AnimatedSwitcher(
            //layoutBuilder: fadeOverLayoutBuilder,
            duration: const Duration(milliseconds: 600),
            child: FractionallySizedBox(
              heightFactor: 1 / 3,
              child: (() {
                if (loginProvider.state == LoginState.disconnected) {
                  return Container(
                      color: Colors.blue, child: const ConnectionButton());
                } else if (loginProvider.state == LoginState.email) {
                  return EmailTextField(
                    knownEmail: loginProvider.email,
                    callback: (email) => loginProvider.verifyEmail(
                        email,
                        (e) => _errorCallback(
                            context, e, "Une erreur s'est produite.")),
                  );
                } else if (loginProvider.state == LoginState.register) {
                  return UnknownAccountLoginForm(
                      callback: (lastname, firstname, password) =>
                          loginProvider.registerAccount(
                              loginProvider.email!,
                              lastname,
                              firstname,
                              password,
                              (e) => _errorCallback(context, e,
                                  "Erreur lors de l'enregistrement.")));
                } else if (loginProvider.state == LoginState.password) {
                  return KnownAccountLoginForm(
                      callback: (password) =>
                          loginProvider.signInWithEmailAndPassword(
                              loginProvider.email!,
                              password,
                              (e) => _errorCallback(
                                  context, e, "Mot de passe invalide.")));
                } else if (loginProvider.state == LoginState.connected) {
                  return DisconnectionButton(
                    width: constraints.maxWidth,
                    height: 20,
                  );
                }
              }()),
            ),
          ),
        );
      });
    });
  }

  void _errorCallback(
      BuildContext context, FirebaseAuthException e, String message) {
    return globals.showErrorDialog(context, 'Erreur de connexion',
        FirebaseAuthException(code: 'e.code', message: message));
  }

  static Widget fadeOverLayoutBuilder(
      Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      children: <Widget>[
        ...previousChildren.map((w) => Positioned(
              child: w,
              top: 0,
              left: 0,
            )),
        if (currentChild != null) currentChild,
      ],
    );
  }
}
