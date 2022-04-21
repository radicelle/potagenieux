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
        return AnimatedSwitcher(
          //layoutBuilder: fadeOverLayoutBuilder,
          duration: const Duration(milliseconds: 600),
          child: (() {
            if (loginProvider.state == LoginState.disconnected) {
              return const ConnectionButton();
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
                          (e) => _errorCallback(
                              context, e, "Erreur lors de l'enregistrement.")));
            } else if (loginProvider.state == LoginState.password) {
              return KnownAccountLoginForm(
                loginCallback: (password) =>
                    loginProvider.signInWithEmailAndPassword(
                  loginProvider.email!,
                  password,
                  (e) => _errorCallback(context, e, "Mot de passe invalide."),
                ),
                forgottenCallback: (email) => loginProvider.askForPassword(
                  email,
                  (e) => _errorCallback(context, e, "Problème de connexion"),
                ),
              );
            } else if (loginProvider.state == LoginState.connected) {
              return const DisconnectionButton();
            }
          }()),
        );
      });
    });
  }

  void _errorCallback(
      BuildContext context, FirebaseAuthException e, String message) {
    return globals.showErrorDialog(context, 'Erreur de connexion',
        FirebaseAuthException(code: 'e.code', message: message));
  }
}
