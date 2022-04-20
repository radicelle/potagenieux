import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/illuminable.dart';
import 'package:provider/provider.dart';

import '../../../providers/login_provider.dart';

class ConnectionButton extends StatelessWidget {
  const ConnectionButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (_, stateProvider, __) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: stateProvider.opacity(ShadingItem.connection),
        child: GestureDetector(
          onTap: () => stateProvider.state = LoginState.email,
          child: Column(
            children: [
              MouseRegion(
                onEnter: (event) =>
                    stateProvider.illuminate(event, ShadingItem.connection),
                onExit: (event) =>
                    stateProvider.shade(event, ShadingItem.connection),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Se connecter",
                      style: globals.loginTextStyle(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LoginProviderState {}
