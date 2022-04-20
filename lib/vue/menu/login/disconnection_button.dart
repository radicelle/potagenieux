import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/illuminable.dart';
import 'package:provider/provider.dart';

import '../../../providers/login_provider.dart';

class DisconnectionButton extends StatelessWidget {
  const DisconnectionButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (_, stateProvider, __) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: stateProvider.opacity(ShadingItem.connection),
        child: GestureDetector(
          onTap: () => stateProvider.signOut(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Se déconnecter",
              style: globals.loginTextStyle(context),
            ),
          ),
        ),
      );
    });
  }
}

class LoginProviderState {}
