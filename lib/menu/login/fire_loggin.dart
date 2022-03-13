import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/menu/login/disconnection_button.dart';
import 'package:potagenieux/menu/login/unknown_account_login_form.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import 'connection_button.dart';
import 'email_text_field.dart';
import 'known_account_login_form.dart';

class FireLogin extends StatefulWidget {
  const FireLogin({required this.width, required this.height, Key? key})
      : super(key: key);

  final double width;
  final double height;

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
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.width,
        maxHeight: widget.height,
      ),
      child: Consumer<LoginProvider>(builder: (_, loginProvider, __) {
        return MouseRegion(
          onEnter: (event) => loginProvider.illuminate(event, Item.connection),
          onExit: (event) => loginProvider.shade(event, Item.connection),
          child: AnimatedSwitcher(
            layoutBuilder: fadeOverLayoutBuilder,
            duration: const Duration(milliseconds: 600),
            child: (() {
              if (loginProvider.state == LoginState.disconnected) {
                return ConnectionButton(
                  width: widget.width,
                  height: widget.height,
                );
              } else if (loginProvider.state == LoginState.email) {
                return EmailTextField(
                  knownEmail: loginProvider.email,
                  callback: (email) => loginProvider.verifyEmail(
                      email,
                      (e) => _errorCallback(
                          context, e, "Une erreur s'est produite.")),
                  width: widget.width,
                  height: widget.height,
                );
              } else if (loginProvider.state == LoginState.register) {
                return UnknownAccountLoginForm(
                    width: widget.width,
                    height: widget.height,
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
                    width: widget.width,
                    height: widget.height,
                    callback: (password) =>
                        loginProvider.signInWithEmailAndPassword(
                            loginProvider.email!,
                            password,
                            (e) => _errorCallback(
                                context, e, "Mot de passe invalide.")));
              } else if (loginProvider.state == LoginState.connected) {
                return DisconnectionButton(
                  width: widget.width,
                  height: widget.height,
                );
              }
            }()),
          ),
        );
      }),
    );
  }

  void _errorCallback(
      BuildContext context, FirebaseAuthException e, String message) {
    return _showErrorDialog(context, 'Erreur de connexion',
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

  void _showErrorDialog(BuildContext context, String title, Exception e) {
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
}
